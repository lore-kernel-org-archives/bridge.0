Return-Path: <shemminger@vyatta.com>
Date: Mon, 3 Dec 2012 21:58:13 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20121203215813.12bd2b38@nehalam.linuxnetplumber.net>
In-Reply-To: <CAJzFV35xUL6xgxc9pssvcGVhfVC+qOPnpMpX635Qk9eR1DkU6Q@mail.gmail.com>
References: <CAJzFV35xUL6xgxc9pssvcGVhfVC+qOPnpMpX635Qk9eR1DkU6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Help IPV6 neighbor cache & Bridging (RTM_NEWNEIGH)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: sharat chandra <sharat04@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 3 Dec 2012 20:15:24 -0700
sharat chandra <sharat04@gmail.com> wrote:

> Hi All,
> 
> I have a simple linux based Access point /Wireless router  setup with
> dual SSID's. Let me explain the setup. I have a bridge interface used
> only for V6 traffic
> 
> brctl addbr bridge0
> brctl addif bridge0 wlan0
> brctl addif bridge wlan1
> 
> The bridge is setup and works fine and cilents are able to associate
> with these SSID's and data traffic works.
> 
> My question is the neighbor cache information is always associated
> with bridge0 i.e the neighbor cache looks like this
> 
> <V6 addr> dev bridge0 lladdr <mac addr> REACHABLE.
> 
> The clients mac address is typically  associated with either wlan0 or
> wlan1 if there was no bridge, but with bridge enabled, its always
> associated with bridge interface.  Is there a way to get the actual
> interface name for a clients mac address that is either wlan0 or wlan1
> from the neighbor cache or from netlink events? Is there any other way
> to get this information?
> 
> Any information would be really helpful.
> 
> Thank You,
> Sharat

All level 3 and higher information should be associate with the bridge.
The bridge device presents the host side interface to local IP and IPv6.
the idea is that the device could transparently move from one interface
(wlan0) to another (wlan1) and the higher levels should not have to know.

If you want to know which interface the device is currently on, you have
to look at the bridge forwarding table (via netlink, sysfs, or ioctl).

