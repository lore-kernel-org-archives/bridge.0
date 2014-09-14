Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=5tewL9MvMlpsHkqpsRztaH3r1qKNQSKCCgVVLWgdwV8=;
	b=FifVxuzjlNLyvRruc5nGT5ovbtSwBUJpt3WC+QspjPXzeZHYlgmQX7pnXO7bV4FPLI
	+tzf/LQCrkm6icY2oqu7ViKbuyGf/dgpEsFSRTrPij9NKhOd58VG9veCbb3LDTaZQcY/
	NZJLmW4kiu/X9T1wc8dA2u2+rZ+6KXksjStM/rPOCpD8R1tcvpMsVp+HUGwNg55odmis
	Pb2Pc8P5D7xrRF/sjl99URvWo0dL/flyN+8fGRiLmjvvHwe95SakRcqy6Wrfmhm/vnu8
	5sF938PUdLcYDU/6UXLah2kbeXkLWEdxXgjPd/fLEy00W8YQmExo4DcOqoUDVbaCejSH
	I6Lw==
Message-ID: <5415B6C2.5030702@gmail.com>
Date: Mon, 15 Sep 2014 00:39:46 +0900
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
MIME-Version: 1.0
References: <1410554691-18467-1-git-send-email-vyasevic@redhat.com>
	<1410554691-18467-4-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1410554691-18467-4-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 3/3] bridge;
 Automatically filter vlans configured on top of bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladislav Yasevich <vyasevich@gmail.com>, netdev@vger.kernel.org
Cc: Vladislav Yasevich <vyasevic@redhat.com>, shemminger@vyatta.com, bridge@lists.linux-foundation.org

(14/09/13 (土) 5:44), Vladislav Yasevich wrote:
> If the user configures vlan devices on top of the bridge,
> automatically set up filter entries for it as long as
> bridge vlan protocol matches that of the vlan.
> This allows the user to atomatically receive vlan traffic
> for the vlans that are convifgured.

Changing br->vlan_proto seems to cause inconsistency between vlan
interfaces and filter settings.
Can we automatically change filters when setting vlan_proto?

>
...
> +static int br_vlan_rx_kill_vid(struct net_device *br_dev,
> +			       __be16 proto, u16 vid)
...
> +	/* Don't report error.  This will fail if the vlan was
> +	 * previousely remove by some other means and we don't
> +	 * wan't to polute the log/bug the user.
> +	 */
> +	br_vlan_delete(br, vid);
> +	return 0;
> +}

It might lead to unexpected behaviour, for example,
1. create br0.10
2. set pvid to 10 on br0
3. delete br0.10
Then, pvid will also be cleared?
Something like ref counting is needed?

Thanks,
Toshiaki Makita
