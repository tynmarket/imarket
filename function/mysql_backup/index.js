const Compute = require('@google-cloud/compute');
const addHours = require('date-fns/add_hours');
const addDays = require('date-fns/add_days');
const lastDayOfMonth = require('date-fns/last_day_of_month');
const format = require('date-fns/format');

const compute = new Compute();
const zoneName = 'asia-northeast1-b';
const zone = compute.zone(zoneName);

const isUTC = (new Date()).getTimezoneOffset() == 0;

// (async () => {
//   console.log('Start backup.\n');
//
//   await createSnapshot();
//   await deleteSnapshot();
//
//   console.log('End backup.');
// })();


exports.run = async (event, context, callback) => {
  console.log('Start backup.');

  const message = Buffer.from(event.data, 'base64').toString();
  console.log(`message: ${message}`);

  const data = JSON.parse(message)

  err = await createSnapshot(data.disk);
  if (err) {
    callback(err);
  } else {
    await deleteSnapshot();
    // 呼ばないとタイムアウトする？
    callback();
  }

  console.log('End backup.');
};

function getDate() {
  if (isUTC) {
    return addHours(new Date(), 9);
  } else {
    return new Date();
  }
}

function snapshotName(date) {
  return 'snapshot-mysql-' + format(date, 'YYYY-MM-DD');
}

async function createSnapshot(diskName) {
  console.log('Start createSnapshot().\n');
  console.log(`disk: ${diskName}`);

  const disk = zone.disk(diskName);

  // 1日前
  const addDay = addDays(getDate(), -1);
  const name = snapshotName(addDay);

  try {
    await disk.createSnapshot(name);
    console.log(`Snapshot ${name} is created.\n`);
  } catch (err) {
    console.log(`Snapshot ${name} is not created.\n`);
    console.log(err);
    return err
  }
}

async function deleteSnapshot() {
  console.log(`Start deleteSnapshot().\n`);

  // 2日前
  const deleteDay = addDays(getDate(), -2);
  const name = snapshotName(deleteDay);
  const snapshot = compute.snapshot(name);

  try {
    await snapshot.delete()
    console.log(`Snapshot ${name} is deleted.\n`)
  } catch (err) {
    console.log(`Snapshot ${name} is not deleted.\n`)
    console.log(err)
  }
}
