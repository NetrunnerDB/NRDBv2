import Component from '@glimmer/component';
import { LinkTo } from '@ember/routing';
import Icon from './icon';

<template>
  <LinkTo @route='home' class='decklist-box-link mt-2'>
    <div class='row px-3' style='height:70px'>
      <div class='col-1 col-lg-2 position-relative font-size-32'>
        <div
          class='decklist-link-faction position-absolute w-75'
          style='top:50%; transform:translateY(calc(-50% - 4px))'
        >
          <Icon @icon='{{@faction}}' />
        </div>
      </div>
      <div class='col-11 col-lg-10 position-relative font-size-14'>
        <div
          class='position-absolute w-75'
          style='top:50%; transform:translateY(-50%)'
        >
          <div class='text-truncate'><b>{{@name}}</b></div>
          <div class='text-truncate'>{{@author}} ({{@karma}})</div>
        </div>
      </div>
    </div>
  </LinkTo>
</template>
