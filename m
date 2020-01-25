Return-Path: <Allan.Nielsen@microchip.com>
Date: Sat, 25 Jan 2020 20:16:12 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200125191612.5dlzlvb7g2bucqna@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-4-horatiu.vultur@microchip.com>
 <20200124174315.GC13647@lunn.ch>
 <20200125113726.ousbmm4n3ab4xnqt@soft-dev3.microsemi.net>
 <20200125152023.GA18311@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200125152023.GA18311@lunn.ch>
Subject: Re: [Bridge] [RFC net-next v3 03/10] net: bridge: mrp: Add MRP
 interface used by netlink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>

On 25.01.2020 16:20, Andrew Lunn wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>On Sat, Jan 25, 2020 at 12:37:26PM +0100, Horatiu Vultur wrote:
>> The 01/24/2020 18:43, Andrew Lunn wrote:
>> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>> >
>> > > br_mrp_flush - will flush the FDB.
>> >
>> > How does this differ from a normal bridge flush? I assume there is a
>> > way for user space to flush the bridge FDB.
>>
>> Hi,
>>
>> If I seen corectly the normal bridge flush will clear the entire FDB for
>> all the ports of the bridge. In this case it is require to clear FDB
>> entries only for the ring ports.
>
>Maybe it would be better to extend the current bridge netlink call to
>be able to pass an optional interface to be flushed?  I'm not sure it
>is a good idea to have two APIs doing very similar things.
I agree.

And when looking at this again, I start to think that we should have
extended the existing netlink interface with new commands, instead of
adding a generic netlink.

/Allan

