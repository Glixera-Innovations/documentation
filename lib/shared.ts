import { createGetUrl } from 'fumadocs-core/source';

export const appName = 'Glixera Innovations';
export const docsRoute = '/';
export const docsImageRoute = '/og/docs';

// fill this with your actual GitHub info, for example:
export const gitConfig = {
  user: 'Glixera-Innovations',
  repo: 'documentation',
  branch: 'main',
};

const getImageUrl = createGetUrl(docsImageRoute);

export function getPageImageUrl(page: { slugs: string[]; locale?: string }) {
  const segments = [...page.slugs, 'image.webp'];

  return { segments, url: getImageUrl(segments, page.locale) };
}
