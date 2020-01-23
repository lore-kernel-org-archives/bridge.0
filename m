Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=date:in-reply-to:references:mime-version:content-transfer-encoding
 :subject:to:cc:from:message-id;
 bh=9PZb53gn3HlYV30IW/3Iin0xPniNCS5s4n7brqy6NFs=;
 b=cv/awR2y1PRHqf6zaD9Uia66fk7WiFyzcNZ3UBvU4btFuYJlOUEwQ0F9cG89sWoVC+
 /CujA9UE+XK+DhVYW7fU8SKZVIcVIYvSGcUQco44WeSfyacHnHD+omZ5rOhZ+LjYiZxw
 YML6rS+jM7HfWvQQCvV09Dh/SQ1E3KsVNnJKk=
Date: Thu, 23 Jan 2020 19:58:35 +0200
In-Reply-To: <20200123082542.06ed0a53@hermes.lan>
References: <20200123132807.613-1-nikolay@cumulusnetworks.com>
 <20200123132807.613-2-nikolay@cumulusnetworks.com>
 <20200123082542.06ed0a53@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: nikolay@cumulusnetworks.com
Message-ID: <B878D56B-BA6C-49A9-877D-5590BC4DC314@cumulusnetworks.com>
Subject: Re: [Bridge] [PATCH net-next 1/4] net: bridge: check port state
	before br_allowed_egress
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 23 January 2020 18:25:42 EET, Stephen Hemminger <stephen@networkplumber=
=2Eorg> wrote:
>On Thu, 23 Jan 2020 15:28:04 +0200
>Nikolay Aleksandrov <nikolay@cumulusnetworks=2Ecom> wrote:
>
>>  	return ((p->flags & BR_HAIRPIN_MODE) || skb->dev !=3D p->dev) &&
>> -		br_allowed_egress(vg, skb) && p->state =3D=3D BR_STATE_FORWARDING &&
>> +		p->state =3D=3D BR_STATE_FORWARDING && br_allowed_egress(vg, skb) &&
>>  		nbp_switchdev_allowed_egress(p, skb) &&
>>  		!br_skb_isolated(p, skb);
>>  }
>
>Maybe break this complex return for readability?

Sure, sounds good, but is not the point of this commit=2E=20
I'll prepare a separate cleanup patch for that=2E=20

Thanks,=20
  Nik

