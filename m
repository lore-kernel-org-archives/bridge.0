Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A001A81ECE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9114A81EC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1691457654;
 x=1692062454; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WR26IpOQQwm4aqVV0c+/k4nzav5EX2MxTcfcAxKBNT0=;
 b=iiOAUEJgNn0G1NceJvzY4gNZ6bYqjJ59dMwtvTUdOpyM83uOBbg3uYEkKP01i+fuVP
 jeff8zyUTRpVQEh9t0jzszwuAyQx5cod9ezC9TC5i3I4wGR5T6dpMYHBg+XSAAuhHREl
 AlAKRhMDoau8cNnD10gGyBJLEXGcgrxjFr7M0LA+zC0Gq2PWQ4ZHSP/YBaqzDxz40grL
 Mt5yqp8gAXa0nhPDIL/3O0tqZaHPP6Itu3YWBAuJrl6prUuil2EZEi4eO4gw44INR1NF
 MJNmIhpgbIKdOsdBKfweLYDYFJng4IdnLrvEq4AD31qhto3GrH7724HpSUmXZtyTB3o6
 kZhg==
Date: Mon, 7 Aug 2023 18:20:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230807182051.47d4d613@hermes.local>
In-Reply-To: <ZNGMVUNsZWWUd7so@sellars>
References: <ZNGMVUNsZWWUd7so@sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Getting + maintaining a consistent MDB view in
 userspace?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux-foundation.org

On Tue, 8 Aug 2023 02:29:09 +0200
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> Hi,
>=20
> Is there a recommended way to get and monitor the MDB state from
> userspace, without potential synchronization races?
>=20
> I can use "bridge monitor mdb" to get changes or "bridge mdb show"
> to get the current state (as well as use the underlying netlink
> calls from my own application without the "bridge" command).
>=20
> But if I were first calling "bridge mdb show" and then "bridge
> monitor mdb" then there is a brief moment where I might miss some
> changes. Or if I were doing it the other way around then a change
> might wrongly override a valid entry? Or the full dump might not
> be as up to date as the change event I got before?
>=20
> Ideally I'd be looking for a variant of "bridge monitor mdb" which
> first dumps the whole, consistent mdb state and after that
> provides updates in the correct order.
>=20
> Regards, Linus

Same issue as dumping routing table which routing daemons deal with.
Most applications end up with two netlink sockets, one for monitor
and one for dumping.

You really can't do it from the bridge utility, need to build your
own tools.
