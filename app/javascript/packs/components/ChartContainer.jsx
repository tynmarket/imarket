import Chart from './Chart';
import React from 'react';
import { useState } from 'react';

const ChartContainer = ({ indices, period, config, children }) => {
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
  const select = e.currentTarget;
  const val = select.options[select.selectedIndex].value; // IE 11
  return val ? parseInt(val) : null;
}

export default ChartContainer;
