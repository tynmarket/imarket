const Compute = require('@google-cloud/compute');
const addMonths = require('date-fns/add_months');
const lastDayOfMonth = require('date-fns/last_day_of_month');
const format = require('date-fns/format');


const compute = new Compute();
const zoneName = 'asia-northeast1-b';
const zone = compute.zone(zoneName);
const disk = zone.disk('mysql-1');

// (async () => {
//   console.log('Start backup.\n');
//
//   await createSnapshot();
//   await deleteSnapshot();
//
//   console.log('End backup.');
// })();


exports.run = async (data, context, callback) => {
  console.log('Start backup.');

  err = await createSnapshot();
  if (err) {
    callback(err);
  } else {
    await deleteSnapshot();
    // 呼ばないとタイムアウトする？
    callback();
  }

  console.log('End backup.');
};

function snapshotName(date) {
  return 'snapshot-mysql-' + format(date, 'YYYY-MM-DD');
}

async function createSnapshot() {
  console.log('Start createSnapshot().\n');

  // 先月末
  const createMonth = addMonths(new Date(), -1);
  const lastDay = lastDayOfMonth(createMonth);
  const name = snapshotName(lastDay);

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

  // 3ヶ月前
  const deleteMonth = addMonths(new Date(), -3);
  const lastDay = lastDayOfMonth(deleteMonth);
  const name = snapshotName(lastDay);
  const snapshot = compute.snapshot(name);

  try {
    await snapshot.delete()
    console.log(`Snapshot ${name} is deleted.\n`)
  } catch (err) {
    console.log(`Snapshot ${name} is not deleted.\n`)
    console.log(err)
  }
}
