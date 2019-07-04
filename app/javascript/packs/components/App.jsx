import { currentConfigFn, entireConfigFn, pointFn } from './ChartConfig';
import { useEffect, useState } from 'react';
import ChartContainer from './ChartContainer';
import React from 'react';
import axios from 'axios';

const App = ({ code, indices }) => {
  const [currentConfig, setCurrentConfig] = useState();
  const [entireConfig, setEntireConfig] = useState();

  useEffect(() => {
    getData(code, indices).then(data => {
      const currentData = data.current_year;
      const currentConfig = getConfig(currentData, currentConfigFn);
      setCurrentConfig(currentConfig);

      const entireData = data.entire_period;
      const entireConfig = getConfig(entireData, entireConfigFn);
      setEntireConfig(entireConfig);
    });
  }, []);

  return (
    <div>
      <ChartContainer
        indices={indices}
        period={'current'}
        config={currentConfig}
      >
        年初来
      </ChartContainer>
      <div className="clearfix" />
      <ChartContainer indices={indices} period={'entire'} config={entireConfig}>
        全期間
      </ChartContainer>
    </div>
  );
};

async function getData(code, indices) {
  const url = `/stock_prices/${code}/${indices}.json`;
  const response = await axios.get(url);
  return response.data;
}

function getConfig(data, configFn) {
  const labels = data.x_label || [];
  const points = (data.data || []).map(pointFn(labels));
  return configFn(labels, points);
}

export default App;
