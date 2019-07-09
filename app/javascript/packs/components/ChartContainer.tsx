/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import Chart from './Chart';
import { Fragment } from 'react';
import { Options } from 'highcharts';
import React from 'react';
import { useState } from 'react';

interface Props {
  indices: string;
  period: string;
  config: Options;
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
    <Fragment>
      <h5 css={header}>{children}</h5>
      <div className="col-7" css={container}>
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
    </Fragment>
  );
};

function selectOptions(indices: string): JSX.Element[] {
  const values =
    indices === 'per'
      ? [undefined, 10, 15, 20, 30, 50, 100]
      : [undefined, 1, 2, 3, 5, 10, 20];
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

const header = css`
  margin-top: 20px;
`;

const container = css`
  box-sizing: border-box;
  height: 350px;
  margin-bottom: 20px;
  padding: 20px 10px 15px 10px;
  border: 1px solid #ddd;
  background: #fff;
  background: linear-gradient(#f6f6f6 0, #fff 50px);
  background: -o-linear-gradient(#f6f6f6 0, #fff 50px);
  background: -ms-linear-gradient(#f6f6f6 0, #fff 50px);
  background: -moz-linear-gradient(#f6f6f6 0, #fff 50px);
  background: -webkit-linear-gradient(#f6f6f6 0, #fff 50px);
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
  -o-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -ms-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -webkit-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
`;

export default ChartContainer;
