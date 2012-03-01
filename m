Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=EA1ycbqDLSAnXOhmmeYeIS6WVvBfPhyAySTCV1idxhY=;
	b=UBCEzHaSrMP2uAbN5TdP1vXxvuhB5OwNwbZP4/1b1iKrCLfXFFWfqfZ92gh/rX8l5B
	xXzyTDK6ViK4s4YBR4ScjcdUx4kvGhEXN5ftcpIFsWgMO9gsXiB4G1UDwFB+4N+Jq7V3
	jwYYoU1mZVl6JfyKKlZzLY/KM6Wv4Q+bGyoVw=
MIME-Version: 1.0
In-Reply-To: <20120301102136.GB6488@1984>
References: <1330593434-19275-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120301102136.GB6488@1984>
Date: Thu, 1 Mar 2012 15:53:29 +0530
Message-ID: <CAOD=uF5O=VJheUhxg7zadpq8p+bqa_M2jiKE1mqLXz6JJps-sg@mail.gmail.com>
From: santosh prasad nayak <santoshprasadnayak@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 2/3] netfilter: potential null derefence.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com

Hi Pablo,

Please look at the last line of my patch.
I have added a new label "out"

regards
santosh

On Thu, Mar 1, 2012 at 3:51 PM, Pablo Neira Ayuso <pablo@netfilter.org> wro=
te:
> On Thu, Mar 01, 2012 at 02:47:14PM +0530, santosh nayak wrote:
>> From: Santosh Nayak <santoshprasadnayak@gmail.com>
>>
>> I am getting following error.
>> " net/bridge/netfilter/ebtables.c:269 ebt_do_table()
>> =A0 error: potential null derefence 'cs'"
>>
>> =A0 =A0 i =3D cs[sp].n; =A0// If cs =3D=3D Null then this will cause pro=
blem.
>>
>> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
>> ---
>> =A0net/bridge/netfilter/ebtables.c | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebta=
bles.c
>> index f3fcbd9..9c0f177 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -209,8 +209,10 @@ unsigned int ebt_do_table (unsigned int hook, struc=
t sk_buff *skb,
>> =A0 =A0 =A0 =A0 =A0smp_processor_id());
>> =A0 =A0 =A0 if (private->chainstack)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D private->chainstack[smp_processor_id(=
)];
>> - =A0 =A0 else
>> + =A0 =A0 else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> There is no "out" label in ebt_do_table !!
