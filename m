Return-Path: <bjorn@mork.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
 t=1597671339; bh=BNq9CJTGRTFMT1lObPrCJUSkmDJn6crINo1uuxFU4b0=;
 h=From:To:Cc:Subject:References:Date:Message-ID:From;
 b=XrsCWJBNvNL9b1DmD3AxQjc9nLE01+xCc5/6j1RYxGn70uVRNhFDEZDexTfITEPU4
 mRoSItYuj9+y+ywq9uw3koXWvR7Ns1Eh3+Mlg8L5XLemunjHGy5lPjCPAssowSVrbR
 G+jVNSgNYsVqydXHI1FVE5H9srXFWwcoRl/u9G7M=
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <87zh6t650b.fsf@miraculix.mork.no> <1830568.o5y0iYavLQ@sven-edge>
Date: Mon, 17 Aug 2020 15:35:38 +0200
In-Reply-To: <1830568.o5y0iYavLQ@sven-edge> (Sven Eckelmann's message of "Mon, 
 17 Aug 2020 15:17:37 +0200")
Message-ID: <87blj95r9x.fsf@miraculix.mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [gluon] Re: [RFC PATCH net-next] bridge: Implement MLD
	Querier wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>

Sven Eckelmann <sven@narfation.org> writes:
> On Monday, 17 August 2020 10:39:00 CEST Bj=C3=B8rn Mork wrote:
>> Linus L=C3=BCssing <linus.luessing@c0d3.blue> writes:
> [...]
>> This is not a bug.  They are deliberately breaking IPv6 because they
>> consider this a feature.  You should not try to work around such issues.
>> It is a fight you cannot win.  Any workaround will only encourage them
>> to come up with new ways to break IPv6.
>
> Who are "they" and

Google.

> where is this information coming from?

I made it up.

> And what do they gain from breaking IPv6?

Battery time.

> Wouldn't it be easier for them just to disable IPv6=20
> than adding random looking bugs?

You would think so.

If it isn't clear, I am hoping to provoke them to re-classify the
"feature" as a bug and fix it.  That's what it takes to prove I am wrong.
Should be easy-peasy.



Bj=C3=B8rn
