import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import Icon from './icon';

<template>
  <LinkTo @route='home' class='box-link latest-set'>
    <div class='row'>
      <div class='col-2 col-lg-4'>
        <img
          src='/assets/image/set/liberation.png'
          alt='Liberation cycle icon'
          style='width:100%; opacity:50%;'
        />
      </div>
      <div class='col-10 col-lg-8 position-relative'>
        <div
          class='position-absolute w-75'
          style='top:50%; transform:translateY(-50%)'
        >
          <div class='text-truncate'>
            Latest set
          </div>
          <div class='text-truncate'>
            The Automata Initiative
          </div>
        </div>
      </div>
    </div>
  </LinkTo>
</template>
