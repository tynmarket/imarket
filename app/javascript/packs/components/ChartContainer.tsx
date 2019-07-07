import Chart from './Chart';
import { Options } from 'highcharts';
import React from 'react';
import { useState } from 'react';

interface Props {
  indices: string;
  period: string;
  config: Options;
  children: React.ReactNode;
}

const ChartContainer: React.FC<Props> = ({
  indices,
  period,
  config,
  children,
}): JSX.Element => {
  const [max, setMax] = useState();
  const id = `${indices}-${period}`;

  return (
    <>
      <h5 className="chart-header">{children}</h5>
      <div className="col-7 per-container">
        <Chart idStr={id} config={config} max={max} />
      </div>
      <div className="operator-container">
        <div>{indices.toUpperCase()}の最大値</div>
        <select
          onChange={(e): void => {
            setMax(maxValue(e));
          }}
          className="select-per form-control"
        >
          {selectOptions(indices)}
        </select>
      </div>
    </>
  );
};

function selectOptions(indices: string): JSX.Element[] {
  const values =
    indices === 'per'
      ? [null, 10, 15, 20, 30, 50, 100]
      : [null, 1, 2, 3, 5, 10, 20];
  return values.map(
    (v, i): JSX.Element => (
      <option value={v} key={i}>
        {v}
      </option>
    )
  );
}

function maxValue(e: React.ChangeEvent<HTMLSelectElement>): number | null {
  const select = e.currentTarget;
  const val = select.options[select.selectedIndex].value; // IE 11
  return val ? parseInt(val) : null;
}

export default ChartContainer;
