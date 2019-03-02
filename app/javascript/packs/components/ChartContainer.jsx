import Chart from './Chart';
import React from 'react';
import { useState } from 'react';

const ChartContainer = ({ indices, config, children }) => {
  const [max, setMax] = useState();

  return (
    <>
      <h5 className="chart-header">{children}</h5>
      <div className="col-7 per-container">
        <Chart config={config} max={max} />
      </div>
      <div className="operator-container">
        <div>{indices.toUpperCase()}の最大値</div>
        <select
          onChange={e => {
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

function selectOptions(indices) {
  const values =
    indices === 'per'
      ? [null, 10, 15, 20, 30, 50, 100]
      : [null, 1, 2, 3, 5, 10, 20];
  return values.map((v, i) => (
    <option value={v} key={i}>
      {v}
    </option>
  ));
}

function maxValue(e) {
  const val = e.currentTarget.selectedOptions[0].value;
  return val ? parseInt(val) : null;
}

export default ChartContainer;
