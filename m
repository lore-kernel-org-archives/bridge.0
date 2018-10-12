Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=date:user-agent:in-reply-to:references:mime-version
	:content-transfer-encoding:subject:to:cc:from:message-id;
	bh=TsVwX2v+mMurRhTa6T0Q3IHKV5GSQzslqDP23Jrs0Gk=;
	b=LIKYudeDlihhbO/5smrd1l4Lo+GDVSJ8GqWsJqe38lc8klUNi79Fs/LfODv6OV4XUY
	WwwO86Hhq3/lyZnq2j2QgJkbSgI4APWrZWNgdyuc1ngXjYQr04PvkvBdWwIneFKSg4IP
	1w54KXaKIt6B/b92CPJ17GaxHodF/skadgXcE=
Date: Fri, 12 Oct 2018 19:04:33 +0300
In-Reply-To: <20181012083932.1753c93e@xeon-e3>
References: <20181012104116.12751-1-nikolay@cumulusnetworks.com>
	<20181012083932.1753c93e@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <028C9C97-5802-40A8-947C-09C631A2FE05@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add support for per-port
	vlan stats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, davem@davemloft.net

On October 12, 2018 6:39:32 PM GMT+03:00, Stephen Hemminger <stephen@networ=
kplumber=2Eorg> wrote:
>On Fri, 12 Oct 2018 13:41:16 +0300
>Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom> wrote:
>
>> This patch adds an option to have per-port vlan stats instead of the
>> default global stats=2E The option can be set only when there are no
>port
>> vlans in the bridge since we need to allocate the stats if it is set
>> when vlans are being added to ports (and respectively free them
>> when being deleted)=2E Also bump RTNL_MAX_TYPE as the bridge is the
>> largest user of options=2E The current stats design allows us to add
>> these without any changes to the fast-path, it all comes down to
>> the per-vlan stats pointer which, if this option is enabled, will
>> be allocated for each port vlan instead of using the global
>bridge-wide
>> one=2E
>>=20
>> CC: bridge@lists=2Elinux-foundation=2Eorg
>> CC: Roopa Prabhu <roopa@cumulusnetworks=2Ecom>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom>
>
>Yes, per-vlan stats could be quite useful=2E
>Most cases of statistics in the kernel are always on, and some API's
>get them (and skip others)=2E  Other than the additional memory overhead,
>why
>not make the statistics as always on=2E
>

The additional overhead can be quite a lot and it also affects performance=
, besides that currently users expect the same accumulated stats=2E

>Also, is there any chance of creating too much data in a netlink
>message if there are 4K-1 VLAN's?

No, that's okay because we expose the stats via the xstats API which
continues the dump on filling the current buffer=2E
We can export as much info as needed=2E

Cheers,
  Nik


