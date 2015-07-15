Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=mn0UjP8Gspkwcu8NQK091DcDYG+VXYDAxo4p5tGTqp0=;
	b=gcOILGZIqT6BYtsO7mJCUWuAFLRGWnTJiQs40b5ZuiS+7PTbFDL9ap2lyRZBm53h1v
	K7gyb9bqdqQSm/CieikYeg1r+0qndV17CMYOKRo6xRd1+06/kOg/LNl071zLRAu5391K
	AAQeYufOqIL+iY6aU/pkoYxZJ+qoBp7eV8W4w=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Wed, 15 Jul 2015 07:16:49 -0700
Message-Id: <1436969811-13237-1-git-send-email-nikolay@cumulusnetworks.com>
Subject: [Bridge] [PATCH net-next 0/2] bridge: multicast: temp and perm
	entries behaviour enhancements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi,
Patch 01 adds a notify when a group is deleted via br_multicast_del_pg()
(on expire, on device delete or on device down).
Patch 02 changes how bridge device and bridge port delete and down/up are
handled. Until now on bridge down all groups were flushed, now only the
temp ones are (same for port), perm entries are flushed only on port or
bridge removal.

Best regards,
 Nikolay Aleksandrov

Nikolay Aleksandrov (2):
  bridge: multicast: notify on group delete
  bridge: multicast: fix handling of temp and perm entries

 net/bridge/br_if.c        |  1 +
 net/bridge/br_multicast.c | 29 ++++++++++++++++++++++-------
 net/bridge/br_private.h   |  1 +
 3 files changed, 24 insertions(+), 7 deletions(-)

-- 
1.9.3

