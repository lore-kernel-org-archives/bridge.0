Message-ID: <bdfc5d6e0803120746u416403a7vedb821805a6412e6@mail.gmail.com>
Date: Wed, 12 Mar 2008 10:46:48 -0400
From: "Andy Gospodarek" <andy@greyhouse.net>
Sender: adgospod@gmail.com
In-Reply-To: <47D74E0C.7060209@redfish-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D57881.2020503@redfish-solutions.com>
	<20080311082347.0140c4d2@extreme>
	<47D74E0C.7060209@redfish-solutions.com>
Subject: Re: [Bridge] Question about using brctl and changing MAC addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: bridge@linux-foundation.org

On Tue, Mar 11, 2008 at 11:29 PM, Philip Prindeville
<philipp_subx@redfish-solutions.com> wrote:
>
> Stephen Hemminger wrote:
>  > On Mon, 10 Mar 2008 11:05:53 -0700
>  > Philip Prindeville <philipp_subx@redfish-solutions.com> wrote:
>  >
>  >
>  >> I'm using Linux 2.6.20 (yes, I'll be upgrading to 2.6.24 as soon as it's
>  >> stable).
>  >>
>  >> I have 4 VIA rhine ethernet controllers on my Soekris net5501, plus an
>  >> ADSL PCI card (a Sangoma S-518) that runs in AAL5-SNAP mode, so it looks
>  >> like an Ethernet controller.
>  >>
>  >> I'm trying to bridge eth0 and w1ad (the ADSL interface) into "br0".  And
>  >> I'm trying to force the traffic on br0 to have the MAC address that my
>  >> ISP insists I use (i.e. that of the crappy little Westell 6100 modem
>  >> they sent me).
>  >>
>  >> The issue is the following.  If I do:
>  >>
>  >> ifconfig w1ad down hw ether x:x:x:x:x:x up
>  >>
>  >> followed by either:
>  >>
>  >> brctl addbr br0
>  >> brctl addif br0 eth0
>  >> brctl addif br0 w1ad
>  >>
>  >> or:
>  >>
>  >> brctl addbr br0
>  >> brctl addif br0 w1ad
>  >> brctl addif br0 eth0
>  >>
>  >> the bridge ends up taking the MAC address of eth0 either way, which I
>  >> don't get (how does it decide which to use?).
>  >>
>  >> I can clone the same MAC address to both eth0 and w1ad, but I don't know
>  >> if that would cause me any problems or not (I haven't read the STP spec
>  >> in about 15 years).
>  >>
>  >>
>  >
>  > Having the same mac address on both just is going to be problematic (impossible
>  > to do STP), so don't if you don't have to.
>  > But you can set address of bridge and eth0 to any address you want. So set these
>  > to the ISP assigned address.  You probably will have to do it after bridge
>  > is created.
>  >
>  > brctl addbr br0
>  > brctl addif br0 w1ad br0
>  > ifconfig eth0 hw ether x:x:x:x:x:x up
>  > ifconfig w1ad up
>  > ifconfig br0 hw ether x:x:x:x:x:x up
>  >
>  > ifconfig br0 A.B.C.D netmask 255.255.255.0
>  >
>
>  That seems to not work.  I get:
>
>  # ifconfig br0 hw ether "00:18:3A:55:15:35"
>
> ifconfig: SIOCSIFHWADDR: Cannot assign requested address
>  #
>
>  Any ideas why?  I'm doing this before an IP address has even been
>  assigned...
>
>  -Philip
>
>
>

Was the interface reported as 'UP' by ifconfig?
