import { LinkTo } from '@ember/routing';
import FaIcon from '@fortawesome/ember-fontawesome/components/fa-icon';

<template>
  <header class="col-md-3 d-none d-xl-flex flex-column px-0">
    <div class="sticky-top vh-100 shadow bg-white mx-2">
      <nav class="navbar pt-0">
        <div class="bg-white py-5 w-100">
          <LinkTo @route="home" class="navbar-brand large-brand d-flex mx-auto">
            <span class="mx-auto">
              <img src="/assets/images/logo.png" alt="NetrunnerDB" />
              <span>NetrunnerDB</span>
            </span>
          </LinkTo>
        </div>
        <ul class="nav navbar-nav w-100">
          <li class="nav-item">
            <LinkTo @route="home.dotw" class="button nav-link w-100">
              <FaIcon @icon="award" />
              Decklist of the Week
            </LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo @route="home.decklists" class="button nav-link w-100">
              <FaIcon @icon="scroll" @flip="horizontal" />
              Browse Decklists
            </LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo @route="home.community" class="button nav-link w-100">
              <FaIcon @icon="comment" @flip="horizontal" />
              Community Feed
            </LinkTo>
          </li>
          <hr />
          <li class="nav-item">
            <LinkTo @route="page.sets" class="button nav-link w-100">
              <FaIcon @icon="inbox" />
              Card Sets
            </LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo @route="page.formats" class="button nav-link w-100">
              <FaIcon @icon="cubes" />
              Play Formats
            </LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo @route="page.banlists" class="button nav-link w-100">
              <FaIcon @icon="ban" />
              Banlists
            </LinkTo>
          </li>
          <hr />
          <li class="nav-item">
            <LinkTo @route="home.updates" class="button nav-link w-100">
              <FaIcon @icon="wrench" @flip="horizontal" />
              Updates
            </LinkTo>
          </li>
          <li class="nav-item">
            <LinkTo @route="home.developer" class="button nav-link w-100">
              <FaIcon @icon="code" />
              Developer Tools
            </LinkTo>
          </li>
        </ul>
      </nav>
    </div>
  </header>
</template>
