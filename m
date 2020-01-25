Return-Path: <Allan.Nielsen@microchip.com>
Date: Sat, 25 Jan 2020 20:12:38 +0100
From: "Allan W. Nielsen" <allan.nielsen@microchip.com>
Message-ID: <20200125191238.qdtd2elypnz6ewhm@lx-anielsen.microsemi.net>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124203406.2ci7w3w6zzj6yibz@lx-anielsen.microsemi.net>
 <87zhecimza.fsf@linux.intel.com>
 <20200125094441.kgbw7rdkuleqn23a@lx-anielsen.microsemi.net>
 <20200125162357.GE18311@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20200125162357.GE18311@lunn.ch>
Subject: Re: [Bridge] [RFC net-next v3 00/10] net: bridge: mrp: Add support
 for Media Redundancy Protocol (MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: ivecera@redhat.com, jiri@resnulli.us, Vinicius Costa Gomes <vinicius.gomes@intel.com>, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, davem@davemloft.net, nikolay@cumulusnetworks.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, Horatiu Vultur <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com

On 25.01.2020 17:23, Andrew Lunn wrote:
>EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>
>> Lets say that the link between H1 and H2 goes down:
>>
>>     +------------------------------------------+
>>     |                                          |
>>     +-->|H1|<---  / --->|H2|<---------->|H3|<--+
>>     eth0    eth1    eth0    eth1    eth0    eth1
>>
>> H1 will now observe that the test packets it sends on eth1, is not
>> received in eth0, meaninf that the ring is open
>
>Is H1 the only device sending test packets? It is assumed that H2 and
>H3 will forward them?
Horatiu, please correct me if I'm wrong, you have been spending more
time with the standard.

It is only the manager/MRM (in this case H1) which sends test-frames.
The other nodes (the MRC's) must forward the MRP-test frames, but only
on the ports which is part of the ring.

> Or does each device send test packets, and when it stops hearing these
> packets from a neighbour, it assumes the link is open?
No.

This also means that most non-MRP aware switches can properly act as
MRC with HW offload. It is good to have that in mind when reviewing the
netlink interface.

It is worth mentioning that the client shall send a frame if they see a
link up/down on one of the ring ports. This is to allow the manager to
react faster.

Also, in this first patch we have only defined the MRM and MRC roles. In
future version we would also like to support a MRA (auto manager), where
the clients is monitoring the test frames, and if there are no manager
(it disappear, or they are all MRA) then they can negotiate who should
take the role as manager.

/Allan
