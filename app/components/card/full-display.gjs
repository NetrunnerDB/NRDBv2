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
          <div class="d-flex justify-content-center mt-3">
            <button id="flip" type="button" class="btn btn-secondary"><i
                class="fa-solid fa-rotate"
              ></i>
              Flip</button>
          </div>
        </div>
        <div class="col-md-8 full-card-text mt-2">
          <div class="card">
            <div class="card-header">
              <div
                id="card-title"
                class="card-title mb-0"
              >{{@printing.title}}</div>
            </div>
            <div class="card-body">
              <div class="row position-relative">
                <div id="card-content" class="col-md-7 border-end">
                  <TextBox
                    @printing={{@printing}}
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
                    <Legality @card={{@printing.card}} @format="standard">
                      <b>Standard</b></Legality>
                    <Legality @card={{@printing.card}} @format="startup">
                      <b>Startup</b></Legality>
                    <Legality @card={{@printing.card}} @format="eternal">
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
                    {{#each @printing.card.printings as |printing|}}
                      <div class="d-flex justify-content-between">
                        <div class="text-truncate">
                          <LinkToCard
                            @printing={{printing}}
                          >{{printing.cardSetName}}</LinkToCard>
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
