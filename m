Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=man3Sqwr2f1mgPdjLHTq8UmfmQ+9wPXOlnlef5RmYuc=;
	b=znrnL6PEd1bn8nk/ww5R83qSZGfZtHveHL4qcH1al8xlhJGniSTnvJPSpWuWgtJ9Ig
	kma7prOiBVVeZgc6YZU2yRmvNg2N020J9E3DMSXPDP86npnbctj1pwe3+o4dygqbfE1S
	/L6cSstF60mUkWAkfa7QNuu0aokTYjBqnyydGbJYIvkpYWDf2fPuFRe5N3j7m7RDgrkX
	wVHTrNJvzmG59ZU8UVXJd2WKbE9ZaeVq/+ck+/yFpP1S6XoGoKp9PJ/LhxHfXFJ9m44C
	rVhFAuTiuE+4ZL6PBh4PSdVvG3/XKr06Ipq1adoOAVtcilQ8A5C2amojzLpsTzqCKG5y
	Nwqg==
Message-ID: <5415B27A.2000508@gmail.com>
Date: Mon, 15 Sep 2014 00:21:30 +0900
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
MIME-Version: 1.0
References: <1410554691-18467-1-git-send-email-vyasevic@redhat.com>
	<1410554691-18467-3-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1410554691-18467-3-git-send-email-vyasevic@redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 2/3] bridge: Add filtering support for
	default_pvid
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
> Currently when vlan filtering is turned on on the bridge, the bridge
> will drop all traffic untill the user configures the filter.  This
> isn't very nice for ports that don't care about vlans and just
> want untagged traffic.
> 
> A concept of a default_pvid was recently introduced.  This patch
> adds filtering support for default_pvid.   Now, ports that don't
> care about vlans and don't define there own filter will belong
> to the VLAN of the default_pvid and continue to receive untagged
> traffic.

If user sets pvid, then vid 1 (default_pvid) will become non-pvid but
still not be filtered, right?
vlan_bitmap of default_pvid shouldn't be cleared on setting pvid?

Thanks,
Toshiaki Makita
