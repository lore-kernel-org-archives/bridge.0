Return-Path: <egrumbach@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=nLiZS513jvXyrZnObRP78S+k1DGyoc01DNxMG2C12uY=;
	b=HcrLcM8Ge4ZMz5+Bnpe0t9dWojxqZ0t5/eJ5XoDnHQDgJKOfkRnVL+9uX7KQo5S6Oc
	3tIh9hOQHOKLGenlsPimTnjmE0LzzO7M/TA/p3/8pa1/iiYB9uEmi5R0sdKBsUMBhR8u
	Wf90u17MS1EgS4f9FF/9dWHlbO5bOcL6t/Nk3ZBgCHChMDmZXctP4IuZWkiswTAQHmKj
	lPHBL83LS+hQRcPgUj4FOLR4VSZSOJb5ckQ6gw/nyRylyTia5rN6ZqQEsJTivkXgss6/
	4uIcARrI6N4dZh+/b3YsD36raZjX5Jb8uuYAA3HCAaS9sb0NMX23cZqeDd4yOsQDbzq/
	oYbw==
MIME-Version: 1.0
In-Reply-To: <1336633015.4334.2.camel@jlt3.sipsolutions.net>
References: <cover.1336538937.git.joe@perches.com>
	<20120509.212110.437114897180819434.davem@davemloft.net>
	<1336632528.4334.1.camel@jlt3.sipsolutions.net>
	<1336632860.22495.6.camel@joe2Laptop>
	<1336633015.4334.2.camel@jlt3.sipsolutions.net>
Date: Thu, 10 May 2012 10:08:13 +0300
Message-ID: <CANUX_P3hhiwAdvHqL=SvAwK2oW09RfC5LnanBSvupBROeWhVuw@mail.gmail.com>
From: Emmanuel Grumbach <egrumbach@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 00/13] net: Add and use ether_addr_equal
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, netfilter@vger.kernel.org, netfilter-devel@vger.kernel.org, Joe Perches <joe@perches.com>, David Miller <davem@davemloft.net>

>> >
>> > > That case you didn't convert in mac80211 is probably the
>> > > bug Johannes was talking about which started this whole
>> > > discussion.
>> >
>> > The bug case that started it all is in net/wireless/scan.c and Emmanue=
l
>> > has since changed it back to memcmp(). Not sure if that's the one you
>> > were referring to or not :-)
>>
>> That's the one that I left alone.
>>
>> Post patch:
>> $ git grep -n -w compare_ether_addr net
>> net/batman-adv/main.h:198: * note: can't use compare_ether_addr() as it =
requires aligned memory
>> net/wireless/scan.c:381: =A0 =A0 =A0 =A0return compare_ether_addr(a->bss=
id, b->bssid);
>
> Ok, great, then that means the fix from Emmanuel won't conflict when it
> gets in.
>

Thanks Joe - as Johannes said this won't conflict with my patch. And
yes the code is now more clear.
