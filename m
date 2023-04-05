Return-Path: <dhamester@jusst.de>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E4A9681F47
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E04D581F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jusst.de; s=dkim;
 t=1680697452; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=INuSPqZWxJYEI4jKMV7zGzhUZ5jYXb1XWxD6oaynKVw=;
 b=TX2cBFmbxN9/W7EAaELqbKj10880M39Gn/l58TDnmBnUa7lf/6sE84QbuidDDpnRYxnobC
 BIpIFJ6agOVaspCp2CAOYbV95Xi2CkZ3vkn1Phj6h/xelSBwqqr5zLSxusQlrlBaDngNvE
 DtDubxYFWOuhIXhUCG7GbYy/TdNv5sH2DQhwRyiVPFE/T6PlCG9BMO9YauNDPDk3Fr7zHW
 mBvrw+tHZ57w12WCFhYj3QQasiLPbw1g7Y+ROA67HZ4nTkh7vdqbR1Nm/6yPo897k2VxrB
 r7gM62c+NgpRJq2brM5o3hZL/IfLyVtlvx4I16Ql6YHiEQ7B1fJmRfRo122vcQ==
Message-ID: <9faba0b5-b7e5-5779-4249-1e01419e51c5@jusst.de>
Date: Wed, 5 Apr 2023 14:26:10 +0200
MIME-Version: 1.0
Content-Language: en-US
From: Dennis Hamester <dhamester@jusst.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Bridge] VLAN-aware multicast querier after if link up
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, bridge@lists.linux-foundation.org

Hi Nikolay,

I'd like your input on an issue I'm running into at the moment.

I setup a bridge to do multicast querying for some vid. This then does 
not work for ports that come up later. It works only for those ports 
that were already up when I set the global vlan options.

Debugging through the kernel I can see that the timers are simply never 
started. Unless I disable and re-enable the querier for that particular vid.

Admittedly, I'm working with 5.15 at the moment. But even on mainline, I 
do not see any relevant changes that would make this work.

I have a simple-ish patch, but I'm wondering whether I'm missing 
something? Is maybe some action from userspace expected when a port 
comes up?

Best
Dennis Hamester


-- 
Dennis Hamester
Software Engineering Lead

jusst.engineering
Wrangelstraße 111
D - 20253 Hamburg

tel: +49 40 521 600 10
fax: +49 40 1800 86 76
mobil: +49 152 310 698 27
mail: dhamester@jusst.de

https://jusst.engineering/

jusst technologies GmbH, Ohlstedter Straße 12, D - 22397 Hamburg
Vertretungsberechtigte Geschäftsführer: Julian Scheel, Sebastian Scheel
Registergericht: Amtsgericht Hamburg
Registernummer: HRB 94300

-

Confidentiality notice:

The content of this email is confidential.
If you are not the intended addressee, or if the information provided in 
this
email or in its attachments is evidently not destined for you, please notify
us immediately and delete the message received in error including all its
attachments. Any unauthorized review, processing, distribution, copying,
storage, printout or other use of this message or its attachments is 
prohibited.
