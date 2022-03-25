Return-Path: <schultz.hans@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=9OJLQ6ye5gJdMBoarB9Cgrd/z/Jtzc4wMw4dqWR4+a8=;
 b=GRfB+qcnr013dAwD92e8Vdl8fv4LNfc8BUWReBkwaz3gxp2W2yrHCgve3zM7T7x2y2
 revHYNT+zAwFunniTrPC0VyCf5yC0FO0CccNY6Bms6IZTZA8Eetbb0/IHqcdcX7a5H9Z
 g1pLpcBb8uWWwNiMB7xzhw9ihiOJr5NOD1HwcmUDC43mPobLg7IENjvFE9S1gCT8TA+T
 afc0p/tPbaDiLZxVvO94z9uXn666UKjfTbQu8c4nrxipo5XOVG+r03kl6rQ/7mCAIgqm
 DkclfAZgdm4fCtMzqMjvKBetWMeZn0WDTzvH055FBg0PqcyqcOtihqrsWC7exuCMIn/6
 cMkw==
From: Hans Schultz <schultz.hans@gmail.com>
In-Reply-To: <20220324142749.la5til4ys6zva4uf@skbuf>
References: <20220317093902.1305816-1-schultz.hans+netdev@gmail.com>
 <20220317093902.1305816-3-schultz.hans+netdev@gmail.com>
 <86o81whmwv.fsf@gmail.com> <20220323123534.i2whyau3doq2xdxg@skbuf>
 <86wngkbzqb.fsf@gmail.com> <20220323144304.4uqst3hapvzg3ej6@skbuf>
 <86lewzej4n.fsf@gmail.com> <20220324110959.t4hqale35qbrakdu@skbuf>
 <86v8w3vbk4.fsf@gmail.com> <20220324142749.la5til4ys6zva4uf@skbuf>
Date: Fri, 25 Mar 2022 08:50:34 +0100
Message-ID: <86czia1ned.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v2 net-next 2/4] net: switchdev: add support
 for offloading of fdb locked flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Hans Schultz <schultz.hans@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On tor, mar 24, 2022 at 16:27, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Thu, Mar 24, 2022 at 12:23:39PM +0100, Hans Schultz wrote:
>> On tor, mar 24, 2022 at 13:09, Vladimir Oltean <olteanv@gmail.com> wrote:
>> > On Thu, Mar 24, 2022 at 11:32:08AM +0100, Hans Schultz wrote:
>> >> On ons, mar 23, 2022 at 16:43, Vladimir Oltean <olteanv@gmail.com> wrote:
>> >> > On Wed, Mar 23, 2022 at 01:49:32PM +0100, Hans Schultz wrote:
>> >> >> >> Does someone have an idea why there at this point is no option to add a
>> >> >> >> dynamic fdb entry?
>> >> >> >> 
>> >> >> >> The fdb added entries here do not age out, while the ATU entries do
>> >> >> >> (after 5 min), resulting in unsynced ATU vs fdb.
>> >> >> >
>> >> >> > I think the expectation is to use br_fdb_external_learn_del() if the
>> >> >> > externally learned entry expires. The bridge should not age by itself
>> >> >> > FDB entries learned externally.
>> >> >> >
>> >> >> 
>> >> >> It seems to me that something is missing then?
>> >> >> My tests using trafgen that I gave a report on to Lunn generated massive
>> >> >> amounts of fdb entries, but after a while the ATU was clean and the fdb
>> >> >> was still full of random entries...
>> >> >
>> >> > I'm no longer sure where you are, sorry..
>> >> > I think we discussed that you need to enable ATU age interrupts in order
>> >> > to keep the ATU in sync with the bridge FDB? Which means either to
>> >> > delete the locked FDB entries from the bridge when they age out in the
>> >> > ATU, or to keep refreshing locked ATU entries.
>> >> > So it seems that you're doing neither of those 2 things if you end up
>> >> > with bridge FDB entries which are no longer in the ATU.
>> >> 
>> >> Any idea why G2 offset 5 ATUAgeIntEn (bit 10) is set? There is no define
>> >> for it, so I assume it is something default?
>> >
>> > No idea, but I can confirm that the out-of-reset value I see for
>> > MV88E6XXX_G2_SWITCH_MGMT on 6190 and 6390 is 0x400. It's best not to
>> > rely on any reset defaults though.
>> 
>> I see no age out interrupts, even though the ports Age Out Int is on
>> (PAV bit 14) on the locked port, and the ATU entries do age out (HoldAt1
>> is off). Any idea why that can be?
>> 
>> I combination with this I think it would be nice to have an ability to
>> set the AgeOut time even though it is not per port but global.
>
> Sorry, I just don't know. Looking at the documentation for IntOnAgeOut,
> I see it says that for an ATU entry to trigger an age out interrupt, the
> port it's associated with must have IntOnAgeOut set.
> But your locked ATU entries aren't associated with any port, they have
> DPV=0, right? So will they never trigger any age out interrupt according
> to this? I'm not clear.

I think that's absolutely right. That leaves two options. Either "port
10" if it has IntOnAgeOut setting, or the reason why I wrote my comments
in this part of the code, that it should be able to add a dynamic entry
in the bridge module from the driver.
