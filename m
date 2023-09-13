Return-Path: <aclaudi@redhat.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CCCD41924
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 90266418E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694627927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pc0YBnnQvigZbTYj35NCXLikktn4/P6vHV3/P7dg5gE=;
 b=BqCegcprotQyrhvRSm5GQ9JtxA5itL+Q8endeJVZevI0fG2nKBt+h9GY9vae6rCm75zcHU
 uzS+lMrVraRyD7caVCry65RLE7c86NQfjGS38ivaoufrqPrr6UMN1kj8G5qavieyl+Hwgw
 noKoIozLgrOZLTnR8R+Q3fhbmRZewvg=
From: Andrea Claudi <aclaudi@redhat.com>
Date: Wed, 13 Sep 2023 19:58:24 +0200
Message-ID: <cover.1694625043.git.aclaudi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH iproute2-next 0/2] configure: add support for color
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, David Ahern <dsahern@gmail.com>, Roopa Prabhu <roopa@nvidia.com>

This series add support for the color parameter in iproute2 configure
script. The idea is to make it possible for iproute2 users and packagers
to set a default value for the color option different from the current
one, COLOR_OPT_NEVER, while maintaining the current default behaviour.

Patch 1 add the color option to the configure script. Users can set
three different values, never, auto and always, with the same meanings
they have for the -c / -color ip option. Default value is 'never', which
results in ip, tc and bridge to maintain their current output behaviour
(i.e. colorless output).

Patch 2 makes it possible for ip, tc and bridge to use the configured
value for color as their default color output.

Andrea Claudi (2):
  configure: add the --color option
  treewide: use configured value as the default color output

 Makefile        |  3 ++-
 bridge/bridge.c |  3 ++-
 configure       | 37 +++++++++++++++++++++++++++++++++++++
 ip/ip.c         |  2 +-
 tc/tc.c         |  2 +-
 5 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.41.0

