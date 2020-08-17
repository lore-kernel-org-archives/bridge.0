Return-Path: <bjorn@mork.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
 t=1597653542; bh=C95bbW+7kVubfEbltvr0JMBVnM229YdJIYgB0IKch3U=;
 h=From:To:Cc:Subject:References:Date:Message-ID:From;
 b=VxX7anktq06S5xmTlfzi/rr01Q++/cCS/cHmPzjvLhkAPtxJw24wGCkdy2oO1mf8c
 KH9dQ/nzmoku1bVNeTYPuzWfBJpjNpAX4f7/7zEyI/v57hekWq+GR93w4dGJaKqusz
 l7Qj7Z0QMZ9Oy4azQdyEUsZsypudV/igvysXABhc=
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
Date: Mon, 17 Aug 2020 10:39:00 +0200
In-Reply-To: <20200816202424.3526-1-linus.luessing@c0d3.blue> ("Linus
 =?utf-8?Q?L=C3=BCssing=22's?= message of "Sun, 16 Aug 2020 22:24:24 +0200")
Message-ID: <87zh6t650b.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
	wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>

Linus L=C3=BCssing <linus.luessing@c0d3.blue> writes:

> Currently there are mobile devices (e.g. Android) which are not able
> to receive and respond to MLD Queries reliably because the Wifi driver
> filters a lot of ICMPv6 when the device is asleep - including
> MLD. This in turn breaks IPv6 communication when MLD Snooping is
> enabled. However there is one ICMPv6 type which is allowed to pass and
> which can be used to wake up the mobile device: ICMPv6 Echo Requests.

This is not a bug.  They are deliberately breaking IPv6 because they
consider this a feature.  You should not try to work around such issues.
It is a fight you cannot win.  Any workaround will only encourage them
to come up with new ways to break IPv6.


Bj=C3=B8rn
