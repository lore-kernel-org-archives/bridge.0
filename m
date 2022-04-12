Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=WtbGB7L0QDeE2I+go9zw8Bu1CtyCG18Co3yY1iUrMXY=;
 b=ZaEFBW4EII8WzlwhSzf+zKPxIRzg6pI962lGZG1WVyYyLaE2cWSS01DKRa0p7ADOkP
 NL2TyoCJnBBV+UPo4GSFISlTwDlNFNsoyohFLDRN04udEoN2euT4a5ep2pPgMeJQifl1
 CE2F4c8Fgf0dWkUYXcMRKIa4jwu15X8upnIDHH6RUFz4pglwbYf3t7ySCjN6bWS0SoWC
 MXhULNYOryUu4uB2xQp3PmgZpBuo8jL5xq1U1OUWTjI973ld/vSPFIGuLXdbIJLSddIc
 0FbIdqjCM1tm1ryeUdI/B9/V3hg4fWAjxCpzjRSh8SaqxLwQu9G1Jt/vl6gFa2glKhON
 Befw==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20220411172042.prh3hy7ehpc5o34f@skbuf>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-6-troglobit@gmail.com>
 <20220411172042.prh3hy7ehpc5o34f@skbuf>
Date: Tue, 12 Apr 2022 09:39:57 +0200
Message-ID: <87k0bubvhu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 05/13] selftests: forwarding: add
	TCPDUMP_EXTRA_FLAGS to lib.sh
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Mon, Apr 11, 2022 at 17:20, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
> On Mon, Apr 11, 2022 at 03:38:29PM +0200, Joachim Wiberg wrote:
>> -	$ns_cmd tcpdump -e -n -Q in -i $if_name \
>> +	if [ -z $TCPDUMP_EXTRA_FLAGS ]; then
>> +		extra_flags=""
>> +	else
>> +		extra_flags="$TCPDUMP_EXTRA_FLAGS"
>> +	fi
>> +
>> +	$ns_cmd tcpdump $extra_flags -e -n -Q in -i $if_name \
>
> Could you call directly "$ns_cmd tcpdump $TCPDUMP_EXTRA_FLAGS ..." here,
> without an intermediary "extra_flags" global variable which holds the
> same content?
>
> You could initialize it just like the way other variables are
> initialized, at the beginning of lib.sh:
>
> TCPDUMP_EXTRA_FLAGS=${TCPDUMP_EXTRA_FLAGS:=}

Ah, yes of course.  Will fix in the next drop!

 /J
 
