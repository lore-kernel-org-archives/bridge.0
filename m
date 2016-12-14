Return-Path: <alexei.starovoitov@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=mCzejHZ/2yoVlMhkGz9SwyfxiYSaJxx70hl775sv1Cs=;
	b=S7hiDPGiryCtefqeKBfvU0DsPQoMVSBHqYjlLofdZDR32Z+8lh3dWXAbkCHktq48ur
	qJVK1fMP04ZIhZbBRkN7phx+l+oA/dmpnRot/7nyA93Edp1l7u01jNKO+E/lAbJZkWWb
	2rFmcJ5bLxkZHgDBD3fOd2Y3obMigAG0DgavUr8VjKLQWUpUt7ke4wNEPTBkkyI+t2Q1
	oO1K5M7ZQJJcCkREUzfJd+AkE3JGElsLWDCTucJ+LG1oX+Qr+3ezDtLGK+SfryNd42RG
	78IjUsYkAKEfOBWlTU+/U1lmgoykc1ya3Ms3A8ShJI7Yb3muZBc/LTrCF0ocSahf1+9b
	likA==
MIME-Version: 1.0
In-Reply-To: <20161214020305.qck2bpxmfh6ltrw7@rere.qmqm.pl>
References: <cfa1f2efae2217b50cbefccbf9ba7f0d24a23c63.1480755768.git.mirq-linux@rere.qmqm.pl>
	<20161213172118.2f55c503@xeon-e3>
	<20161214020305.qck2bpxmfh6ltrw7@rere.qmqm.pl>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Dec 2016 18:21:16 -0800
Message-ID: <CAADnVQLwc6RMf_Va1WRwqzXJti-55+wd+XHwcYsRsDB=12binA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH net-next] net: remove abuse of VLAN DEI/CFI bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, "open list:OPENVSWITCH" <dev@openvswitch.org>

On Tue, Dec 13, 2016 at 6:03 PM, Micha=C5=82 Miros=C5=82aw
<mirq-linux@rere.qmqm.pl> wrote:
> On Tue, Dec 13, 2016 at 05:21:18PM -0800, Stephen Hemminger wrote:
>> On Sat,  3 Dec 2016 10:22:28 +0100 (CET)
>> Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl> wrote:
>> > This All-in-one patch removes abuse of VLAN CFI bit, so it can be pass=
ed
>> > intact through linux networking stack.
>> >
>> > Signed-off-by: Micha=C5=82 Miros=C5=82aw <michal.miroslaw@atendesoftwa=
re.pl>
>> > ---
>> >
>> > Dear NetDevs
>> >
>> > I guess this needs to be split to the prep..convert[]..finish sequence=
,
>> > but if you like it as is, then it's ready.
>> >
>> > The biggest question is if the modified interface and vlan_present
>> > is the way to go. This can be changed to use vlan_proto !=3D 0 instead
>> > of an extra flag bit.
>> >
>> > As I can't test most of the driver changes, please look at them carefu=
lly.
>> > OVS and bridge eyes are especially welcome.
>> >
>> > Best Regards,
>> > Micha=C5=82 Miros=C5=82aw
>> Is the motivation to support 802.1ad Drop Eligability Indicator (DEI)?
>>
>> If so then you need to be more verbose in the commit log, and lots more
>> work is needed. You need to rename fields and validate every place a
>> driver is using DEI bit to make sure it really does the right thing
>> on that hardware. It is not just a mechanical change.
>
> My main motivation is to be able to see the bit intact in tcpdump and be
> able to pass it untouched through at least a veth pair. It would be great
> if all devices didn't do something stupid with the bit, but it's not
> something I am able to make happen.

imo "be able to pass untouched through veth" is not good enough
justification for such invasive patches.
I'm still not sure that all of these changes don't affect user space.
