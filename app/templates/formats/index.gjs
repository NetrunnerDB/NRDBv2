import { pageTitle } from 'ember-page-title';
import { formatMessage, formatDate } from 'ember-intl';
import { hash } from '@ember/helper';
import { LinkTo } from '@ember/routing';

import Titlebar from 'netrunnerdb/components/titlebar';
import Navbar from 'netrunnerdb/components/navbar';
import FancyHeader from 'netrunnerdb/components/fancy-header';

const FormatSection = <template>
  <div class="col-12">
    <FancyHeader>{{@format.name}}</FancyHeader>
    <img
      alt={{@format.name}}
      src="/assets/image/format/{{@format.name}}.png"
      class="float-{{@float}} me-4"
      style="width: 100px"
    />

    {{yield to="description"}}

    <h3>Current Ban List</h3>
    <p>
      <LinkTo
        @route="bans"
        @query={{hash format=@format.id search=@format.currentRestriction.name}}
      >
        {{formatMessage
          "{name} active as of {dateStart}"
          name=@format.currentRestriction.name
          dateStart=(formatDate
            @format.currentRestriction.dateStart
            day="numeric"
            month="long"
            year="numeric"
          )
        }}
      </LinkTo>
    </p>
  </div>
</template>;

<template>
  {{pageTitle "Formats"}}

  <main class="pb-4">

    <Navbar />
    <Titlebar
      @title="Formats"
      @subtitle="All official past and present formats of play"
    />

    <div class="container">
      <div class="row">
        <FormatSection @format={{@model.standard.format}} @float="start">
          <:description>
            <p>
              The flagship format of Netrunner Organized Play, Standard is
              frequently changing to keep the meta exciting and engaging for
              players of all levels. Most official Organized Play events will
              follow the Standard format. If a format is not specified, assume
              Standard, but contact your Tournament Organizer for clarity.
            </p>
          </:description>
        </FormatSection>

        <FormatSection @format={{@model.startup.format}} @float="end">
          <:description>
            <p>
              If you’re looking to get into organized play, Startup is the place
              to, well, start. It’s a limited-cardpool format, intended for new
              players taking their first steps into Organized Play as well as
              experienced players who want a slimmed-down deckbuilding
              challenge. The cardpool for Startup consists of:</p>
            <ul class="mt-2">
              <li>System Gateway and System Update 2021</li>
              <li>The most recent complete Null Signal narrative cycle</li>
              <li>All sets in the current incomplete Null Signal narrative cycle</li>
            </ul>
          </:description>
        </FormatSection>

        <FormatSection @format={{@model.eternal.format}} @float="start">
          <:description>
            <p>
              Eternal is not affected by rotation and has a far less restrictive
              list governing it. The largest and most complex format, it
              encompasses nearly the entirety of the printed card pool and only
              grows larger with time.</p>
            <p class="mt-2">
              The Eternal Points List bans a small number of cards, and assigns
              a points value between 0 and 3 points to every card in the format.
              You have 7 points to spend during deckbuilding (these are not
              shared between your Corp and Runner decks – each deck can have up
              to 7 points spent on it). Spending the points cost of a card
              allows you to include up to a full playset of that card in your
              deck. Any card not included in the list below has a points cost of
              0.</p>
          </:description>
        </FormatSection>

        <div class="col-12 col-lg-6">
          <FancyHeader>Random Access Memories</FancyHeader>
          <img
            alt="Random Access Memories"
            src="/assets/image/format/ram.png"
            class="float-end float-lg-start ms-4 ms-lg-0 me-0 me-lg-4"
            style="width: 100px"
          />
          {{! template-lint-disable no-whitespace-within-word }}
          <p>
            Random Access Memories is a special format with a a randomly
            determined card pool. The legal sets for each period are generated
            in a
            <a href="https://www.twitch.tv/nullsignalnetrunner">livestreamed
              draw</a>. This is followed by a tournament, and the sets drawn are
            then the legal RAM card pool for the following period. Please
            <a
              href="https://nullsignal.games/blog/random-access-memories-format-and-tournament/"
            >see here</a>
            for more info on how the card pool is generated.</p>
          <p class="mt-2">
            The regularly-scheduled RAM tournaments are currently on hiatus, and
            the card pool generated for the latest tournament is provided for
            historical purposes. However, you can find tools with which to
            randomly generate your own card pool if you wish to run unofficial
            tournaments on
            <a href="https://ram-checker.lostgeek.de/randomizer.html">this page</a>,
            and you can visit
            <a href="https://ram-checker.lostgeek.de/">this page</a>
            to find a legality checker for your RAM decks.</p>
        </div>

        <div class="col-12 col-lg-6">
          <FancyHeader>Snapshot</FancyHeader>
          <img
            alt="Snapshot"
            src="/assets/image/format/snapshot.png"
            class="float-start float-lg-end ms-0 ms-lg-4 me-4 me-lg-0"
            style="width: 100px"
          />
          <p>This format is a “snapshot” of the meta at Magnum Opus 2018, the
            culmination of FFG Organized Play. It will see minimal changes
            unless strictly necessary.</p>
        </div>

        <div class="col-12">
          <FancyHeader>Other Formats</FancyHeader>
          <p>There are, of course, many other ways to play Netrunner! The
            Netrunner community is nothing if not passionate and creative, so be
            sure to check community hubs for unofficial formats or to share your
            own.</p>
        </div>
      </div>

    </div>

  </main>
</template>
