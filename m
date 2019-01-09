Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4fTcU4EZXBpjT3DOdD+uyvoQAQrPsofNzTgzHBEbvf8=;
	b=NMPfYHRTEOPsUnlqyOsB7Zk8Y7PRot8xERdhcEDKmjTmRIYrJ+dWpmmtdtX7fNj0c0
	8eVzAm4DWh/bxJ2sAlbN8sgAYLICFIdm4T/i3x2Pe3o7Sy39U4TKGamuZ7zoGf0rH7ay
	c0M7nvdUyhqUnUOK0OC5Z5g/zeRQDYbh7OmK/JxHfkhPi1Ee9M5cT6dQ/35Y3EPodW9i
	+/B9OCAPmB9IvwdMU/dnLmk0XsKd6fUh/KQfI9Obdy91sGyLP+emfCLiB9BgJdz3hObo
	vW8i9djekJdBvW50rpXns/EuC7dOqQuLwk9fwuwtbjdga0KPl1VQ+8ZmPy/CKFOQKkH0
	Hx3g==
References: <20190103224702.21541-1-f.fainelli@gmail.com>
	<20190104135837.GB11955@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <357c847d-1b74-20dc-383b-2f9119d66a41@gmail.com>
Date: Tue, 8 Jan 2019 20:39:21 -0800
MIME-Version: 1.0
In-Reply-To: <20190104135837.GB11955@splinter>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

Le 1/4/19 à 5:58 AM, Ido Schimmel a écrit :
> On Thu, Jan 03, 2019 at 02:47:02PM -0800, Florian Fainelli wrote:
>> +A switchdev driver can also refuse to support dynamic toggling of the VLAN
>> +filtering knob at runtime and require a destruction of the bridge device(s) and
>> +a creation of new bridge device(s) with a different VLAN filtering value to
>> +ensure VLAN awareness is pushed down to the HW.
> 
> ...
> 
>> +Similarly to VLAN filtering, if dynamic toggling of the IGMP snooping
> 
> I think you meant to continue this sentence with something about vetoing
> the operation. Note that it is not currently possible as
> br_mc_disabled_update() returns void. Can be extended if needed.

Yes, that's what I meant, that change is queued in my local branch right
now which will get submitted once net-next open backs again.

Thanks!
-- 
Florian
