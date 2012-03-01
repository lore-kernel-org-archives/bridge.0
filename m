Return-Path: <santoshprasadnayak@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=YmZPFGRry3ftj/Q4TF94mEajY4+kZDzJTFk5e5qV7j0=;
	b=WOsvTj2JxR8bqMaQKphsRpNCGGzVHPC+1KzbawyzokNIpCDV9YY0R7xYO+WvCQhJFv
	HLXKz2biNeE/gBej/NfH2pydGRx7EpNunopZ/ETwKtaD8yJF5tjmyTeVgCWGmSamPmVl
	Vo3ncoxr1LPCx30JF7+wXG8ZK0MRxtovk1hpA=
MIME-Version: 1.0
In-Reply-To: <20120301102341.GC6488@1984>
References: <1330593466-19317-1-git-send-email-santoshprasadnayak@gmail.com>
	<20120301102341.GC6488@1984>
Date: Thu, 1 Mar 2012 15:54:58 +0530
Message-ID: <CAOD=uF6T-POkOORw6_S7_NtHgLX4GJj_9A8tg4QRCc8=gCvFaA@mail.gmail.com>
From: santosh prasad nayak <santoshprasadnayak@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH 3/3] netfilter: Remove redundant code.
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

Please see last line of my 2nd patch.
I have added a new label "out" .


regards
santosh

On Thu, Mar 1, 2012 at 3:53 PM, Pablo Neira Ayuso <pablo@netfilter.org> wro=
te:
> On Thu, Mar 01, 2012 at 02:47:46PM +0530, santosh nayak wrote:
>> From: Santosh Nayak <santoshprasadnayak@gmail.com>
>>
>> Remove the redundant code.
>>
>> Signed-off-by: Santosh Nayak <santoshprasadnayak@gmail.com>
>> ---
>> =A0net/bridge/netfilter/ebtables.c | =A0 18 ++++++------------
>> =A01 files changed, 6 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebta=
bles.c
>> index 9c0f177..1efc234 100644
>> --- a/net/bridge/netfilter/ebtables.c
>> +++ b/net/bridge/netfilter/ebtables.c
>> @@ -226,10 +226,8 @@ unsigned int ebt_do_table (unsigned int hook, struc=
t sk_buff *skb,
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (EBT_MATCH_ITERATE(point, ebt_do_match, s=
kb, &acpar) !=3D 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto letscontinue;
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (acpar.hotdrop) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_unlock_bh(&table->lock);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NF_DROP;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (acpar.hotdrop)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> This is really broken! there's no "out" label in ebt_do_table as in
> the previous patch!
