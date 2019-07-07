import {
  ConfigFn,
  Point,
  PointFun,
  currentConfigFn,
  entireConfigFn,
  entirePointFn,
} from './ChartConfig';
import { useEffect, useState } from 'react';
import ChartContainer from './ChartContainer';
import { Options } from 'highcharts';
import React from 'react';
import axios from 'axios';

interface StockPriceData {
  current_year: {
    data: number[];
    x_label: string[];
  };
  entire_period: {
    data: number[];
    x_label: string[];
  };
}

interface Props {
  code: string;
  indices: string;
}

const App: React.FC<Props> = ({ code, indices }): JSX.Element => {
  const [currentConfig, setCurrentConfig] = useState();
  const [entireConfig, setEntireConfig] = useState();

  useEffect((): void => {
    getData(code, indices).then((data: StockPriceData): void => {
      const currentData = data.current_year;
      const currentConfig = getConfig(
        currentData.data,
        currentData.x_label,
        null,
        currentConfigFn
      );
      setCurrentConfig(currentConfig);

      const entireData = data.entire_period;
      const entireConfig = getConfig(
        entireData.data,
        entireData.x_label,
        entirePointFn,
        entireConfigFn
      );
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

async function getData(code: string, indices: string): Promise<StockPriceData> {
  const url = `/stock_prices/${code}/${indices}.json`;
  const response = await axios.get(url);
  return response.data;
}

function getConfig(
  data: number[],
  labels: string[],
  pointFn: (labels: string[]) => PointFun,
  configFn: ConfigFn
): Options {
  let points: Point[] = data || [];
  labels = labels || [];
  if (pointFn) {
    points = data.map(pointFn(labels));
  }
  return configFn(points, labels);
}

export default App;
