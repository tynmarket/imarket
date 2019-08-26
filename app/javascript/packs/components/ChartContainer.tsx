/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import Chart from './Chart';
import { Fragment } from 'react';
import { Options } from 'highcharts';
import React from 'react';
import { media } from '../styles/variables';
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
      <div css={operator}>
        <div>{indicesName(indices)}の最大値</div>
        <select
          onChange={(e): void => {
            setMax(maxValue(e));
          }}
          className="form-control"
          css={selectMax}
        >
          {selectOptions(indices)}
        </select>
      </div>
    </Fragment>
  );
};

function indicesName(indices: string): string {
  if (indices == 'fcf-ratio') {
    return 'FCF倍率';
  } else {
    return indices.toUpperCase();
  }
}

function selectOptions(indices: string): JSX.Element[] {
  let values;

  if (indices == 'per') {
    values = [undefined, 10, 15, 20, 30, 50, 100];
  } else if (indices == 'pbr') {
    values = [undefined, 1, 2, 3, 5, 10, 20];
  } else {
    values = [undefined, 10, 20, 50, 100, 200, 500];
  }
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
  height: 400px;
  margin-bottom: 20px;
  padding: 20px 10px 15px 10px;
  border: 1px solid #ddd;
  background: #fff;
  box-shadow: 0 3px 10px rgba(0, 0, 0, 0.15);
  -o-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -ms-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -moz-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
  -webkit-box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);

  ${media.mobile} {
    height: 350px;
  }
`;

const operator = css`
  ${media.tablet} {
    margin-left: 15px;
    float: left;
  }
`;

const selectMax = css`
  ${media.tablet} {
    margin-top: 5px;
  }
`;

export default ChartContainer;
