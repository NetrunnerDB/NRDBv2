import { LinkTo } from '@ember/routing';
import { pageTitle } from 'ember-page-title';

import Navbar from 'netrunnerdb/components/navbar';
import FancyHeader from 'netrunnerdb/components/fancy-header';

<template>
  {{pageTitle 'Factions'}}

  <main class='pb-4'>

    <Navbar />

    <div class='container'>
      <FancyHeader>Runner Factions</FancyHeader>
      <div
        class='row row-cols-1 row-cols-md-2 row-cols-lg-5 justify-content-center gy-4'
      >
        <div class='col'>
          <LinkTo @route='faction' @model='anarch'>
            <div class='card'>
              <img
                alt='Anarch'
                src='/assets/image/faction/banner/anarch.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-anarch'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Anarch
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='criminal'>
            <div class='card'>
              <img
                alt='Criminal'
                src='/assets/image/faction/banner/criminal.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-criminal'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Criminal
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='shaper'>
            <div class='card'>
              <img
                alt='Shaper'
                src='/assets/image/faction/banner/shaper.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-shaper'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Shaper
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='neutral_runner'>
            <div class='card'>
              <img
                alt='Shaper'
                src='/assets/image/faction/banner/neutral_runner.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-neutral-runner'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Neutral Runner
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
      </div>

      <FancyHeader>Corp Factions</FancyHeader>
      <div
        class='row row-cols-1 row-cols-md-2 row-cols-lg-5 justify-content-center gy-4'
      >
        <div class='col'>
          <LinkTo @route='faction' @model='haas_bioroid'>
            <div class='card'>
              <img
                alt='Haas-Bioroid'
                src='/assets/image/faction/banner/haas_bioroid.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-haas-bioroid'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Haas-Bioroid
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='jinteki'>
            <div class='card'>
              <img
                alt='Jinteki'
                src='/assets/image/faction/banner/jinteki.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-jinteki'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Jinteki
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='nbn'>
            <div class='card'>
              <img
                alt='NBN'
                src='/assets/image/faction/banner/nbn.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-nbn'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  NBN
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='weyland_consortium'>
            <div class='card'>
              <img
                alt='Weyland Consortium'
                src='/assets/image/faction/banner/weyland_consortium.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-weyland-consortium'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Weyland Consortium
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='neutral_corp'>
            <div class='card'>
              <img
                alt='Neutral Corp'
                src='/assets/image/faction/banner/neutral_corp.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-neutral-corp'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Neutral Corp
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
      </div>

      <FancyHeader>Mini Factions</FancyHeader>
      <div
        class='row row-cols-1 row-cols-md-2 row-cols-lg-5 justify-content-center gy-4'
      >
        <div class='col'>
          <LinkTo @route='faction' @model='adam'>
            <div class='card'>
              <img
                alt='Adam'
                src='/assets/image/faction/banner/adam.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-adam'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Adam
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='apex'>
            <div class='card'>
              <img
                alt='Apex'
                src='/assets/image/faction/banner/apex.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-apex'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Apex
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
        <div class='col'>
          <LinkTo @route='faction' @model='sunny_lebeau'>
            <div class='card'>
              <img
                alt='Sunny Lebeau'
                src='/assets/image/faction/banner/sunny_lebeau.gif'
                class='card-img-top'
              />
              <div class='card-body bg-img-sunny-lebau'>
                <h5 class='card-title text-center text-nowrap mb-0'>
                  Sunny Lebeau
                </h5>
              </div>
            </div>
          </LinkTo>
        </div>
      </div>
    </div>

  </main>
</template>
