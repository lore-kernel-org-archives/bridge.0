From: "Adam Hewgill" <ahewgill@hotmail.com>
Subject: Re: [Bridge] Bringing up bridge at boot (properly)
Date: Wed, 30 Jun 2004 13:51:19 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY19-F21HzvB6zLEoS000bee2d@hotmail.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org


Instead of answering the question asking for more detail let me
pose a new question that will be more beneficial.

vvvvvvvvvvvvvvvvvv

If you are using a machine as an ethernet bridge how are you
configuring it (include distro specific stuff) to create and enable the
bridge during the boot process?

^^^^^^^^^^^^

Thanks,
Adam  :o)


From: Stephen Hemminger <shemminger@osdl.org>
To: "Adam Hewgill" <ahewgill@hotmail.com>
CC: bridge@osdl.org
Subject: Re: [Bridge] Bringing up bridge at boot (properly)
Date: Wed, 30 Jun 2004 09:33:56 -0700

On Wed, 30 Jun 2004 11:30:30 -0400
"Adam Hewgill" <ahewgill@hotmail.com> wrote:

 >
 > Currently my ethernet bridge has 2 intel 100mps NIC's that are
 > both part of a bridge. ( I followed the sample setup on the bridge.sf.net
 > page.)
 >
 > In addition to this I would like to access the internet from within the
 > ethernet bridge and when using the sample instructions I have no
 > gateway setup and no default route (0.0.0.0).  I know this data has
 > to be attached to the bridge device and not to an ethX card but I
 > don't know how to do this.
 >
 > Also I would like the bridge to come up and the ethX cards to be
 > added and the bridge configured at boot.  I don't like the idea
 > of using a rc.local script and would like to use /etc/sysconfig/network
 > if this is possible.   Is there a setup doc that describes this 
somewhere?
 >
 > Thanks for the help
 >
 > Adam :o)

The setup of network interfaces varies in each Linux distribution.
What version are you using? and do you want to use DHCP?


