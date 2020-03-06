const IncomingWebhook = require('@slack/client').IncomingWebhook;

// subscribe is the main function called by Cloud Functions.
exports.run = (event, context, callback) => {
  console.log('Start');

  const data = Buffer.from(event.data, 'base64').toString();
  console.log(`data: ${data}`);
  console.log(`SLACK_WEBHOOK_URL: ${process.env.SLACK_WEBHOOK_URL}`);

  const build = eventToBuild(event.data);

  const status = ['QUEUED', 'WORKING'];

  if (status.includes(build.status)) {
    return callback();
  }

  const webhook = new IncomingWebhook(process.env.SLACK_WEBHOOK_URL);

  // Send message to Slack.
  const message = createSlackMessage(build);
  (async () => {
    await webhook.send(message);
  })();
};

// eventToBuild transforms pubsub event message to a build object.
const eventToBuild = (data) => {
  return JSON.parse(new Buffer(data, 'base64').toString());
};

// createSlackMessage creates a message from a build object.
const createSlackMessage = (build) => {
  const source = build.source.repoSource;
  const icon = build.status === 'SUCCESS' ? ':white_check_mark:' : ':warning:';
  const text = `${icon}${build.status}`

  const message = {
   text: `Build \`${source.repoName}/${source.branchName}\``,
    mrkdwn: true,
    attachments: [
      {
        title: 'Build logs',
        title_link: build.logUrl,
        fields: [{
          title: 'Status',
          value: text || 'No status'
        }]
      }
    ]
  };
  return message
};
