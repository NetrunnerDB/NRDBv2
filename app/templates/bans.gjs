import { pageTitle } from 'ember-page-title';
import BanlistTabs from 'netrunnerdb/components/banlist/tabs';

<template>
  {{pageTitle 'Ban Lists'}}

  <div class='container'>
    <div class='row'>
      <div
        class='col-12 col-xl-8 offset-xl-2 d-flex flex-row flex-sm-column my-2'
      >
        <div class='card border-0 flex-grow-1' id='nav-main-content'>
          <div
            class='card-body d-flex flex-column flex-lg-row justify-content-between'
          >

            <div class='container' id='banlists'>
              <h1>Ban Lists</h1>
              <div>
                <p>There are currently three official
                  <a href='/en/formats'>formats</a>
                  supported by Null Signal Games: Startup, Standard, and
                  Eternal. This page displays the ban lists for each.</p>
                <h2>Explanation</h2>
                <ul>
                  <li><b>Banned:</b>
                    You cannot include any copies of a banned card in your deck.</li>
                  <li><b>Points:</b>
                    Including any number of copies of a card with points in
                    Eternal adds points to your deck. Eternal decks must have 7
                    points or fewer.</li>
                  <li><b>Restricted (deprecated):</b>
                    You may include up to a full playset of only one restricted
                    card.</li>
                  <li><b>Universal Influence (deprecated):</b>
                    Cards with universal influence cost additional influence to
                    include in a deck.</li>
                  <li><b>Identity Influence Reduction (deprecated):</b>
                    These cards reduce your identity's influence limit by 1 for
                    each copy (to a minimum of 1).</li>
                </ul>
                <p>See
                  <a
                    href='https://nullsignal.games/players/supported-formats/'
                  >Null Signal Games' Supported Formats page</a>
                  for more information.</p>

                <BanlistTabs
                  @loadedFormats={{@model.loadedFormats}}
                  @formats={{@model.formats}}
                  @selectedFormat={{@controller.format}}
                  @query={{@controller.search}}
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
