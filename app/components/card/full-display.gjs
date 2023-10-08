import { LinkTo } from '@ember/routing';
import Image from './image';
import TextBox from './text-box';
import Legality from './legality';
import LinkToCard from './link-to';

<template>
  <div class="card border-0 flex-grow-1" id="nav-main-content">
    <div class="card-body mx-3 my-1">
      <div class="row">
        <div class="col-md-4 px-4 px-md-0 z-index-10">
          <div id="card-image" class="mx-auto px-4 px-md-0">
            <Image src={{@printing.images.nrdb_classic.large}} />
          </div>
          {{#if false}}
          {{! Re-enable this with a check on if this is a flip card when the API supports those explicitly. }}
          <div class="d-flex justify-content-center mt-3">
            <button id="flip" type="button" class="btn btn-secondary"><i
                class="fa-solid fa-rotate"
              ></i>
              Flip</button>
          </div>
          {{/if}}
        </div>
        <div class="col-md-8 full-card-text mt-2">
          <div class="card">
            <div class="card-header">
              <div
                id="card-title"
                class="card-title mb-0"
              >{{#if @printing.isUnique }}♦ {{/if}}{{@printing.title}}</div>
            </div>
            <div class="card-body">
              <div class="row position-relative">
                <div id="card-content" class="col-md-7 border-end">
                  <TextBox
                    @cardSet={{@cardSet}}
                    @cardType={{@cardType}}
                    @faction={{@faction}}
                    @printing={{@printing}}
                    @showIllustrators={{true}}
                    @showThumbnail={{false}}
                    @showFlavor={{true}}
                    @showProduction={{true}}
                  />
                </div>
                <div class="col-md-5">
                  <hr class="d-md-none" />
                  <div class="button-array">
                    <button type="button" class="btn btn-secondary">Related cards</button>
                    <button type="button" class="btn btn-secondary">Decks with
                      this card</button>
                    <button type="button" class="btn btn-secondary">Download image</button>
                    <button type="button" class="btn btn-secondary">Download text</button>
                    <button type="button" class="btn btn-secondary">Download JSON</button>
                  </div>
                  <hr />
                  <div id="legalities">
                    <Legality @printing={{@printing}} @format="standard" @snapshot={{@standardSnapshot}}>
                      <b>Standard</b></Legality>
                    <Legality @printing={{@printing}} @format="startup" @snapshot={{@startupSnapshot}}>
                      <b>Startup</b></Legality>
                    <Legality @printing={{@printing}} @format="eternal" @snapshot={{@eternalSnapshot}}>
                      <b>Eternal</b></Legality>
                  </div>
                  <hr />
                  <div class="d-flex justify-content-between">
                    <div class="text-truncate">
                      <b>Sets</b>
                    </div>
                    <div>
                      <b>View in set</b>
                    </div>
                  </div>
                  <div id="printings">
                    {{#each @otherPrintings as |printing|}}
                      <div class="d-flex justify-content-between">
                        <div class="text-truncate">
                          <LinkTo
                            @route="page.set"
                            @model="{{printing.cardSetId}}"
                          >{{printing.cardSetName}}</LinkTo>
                          {{! TODO: point this at the set page once that's implemented }}
                        </div>
                        <div>
                          <LinkToCard
                            @printing={{printing}}
                          >(view)</LinkToCard>
                        </div>
                      </div>
                    {{/each}}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
