Message-ID: <41E3C868.5040605@redhat.com>
Date: Tue, 11 Jan 2005 07:36:56 -0500
From: Neil Horman <nhorman@redhat.com>
MIME-Version: 1.0
Subject: Re: [Bridge] Re: tg3 bridge problems
References: <20050110140638.GH7529@thunderchild.debian.net>
	<41E299D4.2010605@redhat.com>
	<20050110154506.GJ7529@thunderchild.debian.net>
	<41E2A7A7.3060109@redhat.com>
	<20050110161855.GK7529@thunderchild.debian.net>
	<41E2BE29.8090800@redhat.com>
	<20050110191133.GM7529@thunderchild.debian.net>
	<41E2DA6E.8090703@redhat.com>
	<20050110194914.GN7529@thunderchild.debian.net>
	<1105416406.4923.8.camel@localhost.localdomain>
	<20050111085216.GA10074@thunderchild.debian.net>
In-Reply-To: <20050111085216.GA10074@thunderchild.debian.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Gergely Madarasz <gorgo@broadband.hu>
Cc: linux-net@vger.kernel.org, bridge@lists.osdl.org

Gergely Madarasz wrote:
> On Tue, Jan 11, 2005 at 02:36:46PM +1030, Paul Schulz wrote:
> 
>>Greetings,
>>
>>This may be the problem that I have seen (and reported) previously...
>>http://oss.sgi.com/projects/netdev/archive/2004-02/msg00442.html
>>
>>One suggestion.. do a packet dump on an outgoing bridge port, and a 
>>dump from a transmitting machine connected to the bridge. Compare the
>>MD5 checksums.
> 
> 
> Thanks for the idea, but it doesn't seem to help. I've modified the patch
> to apply to my chipset revision (and added a debugging printk to make sure
> I've hit the right chipset :)), but nothing really changed. I didn't
> expect it to either, because this is not a transmit problem, but a
> promiscuous receive problem of the driver/card.
> 
> Greg
> 
You know, there is a tg3_dump_state function that if 0-ed out at the 
moment, which among other things dumps out the chips RX_MODE.  You could 
  uncomment that function and tie it to a private ioctl which you could 
call from user space.  That way you could compare the RX_MODE values in 
a working and a failing environment. If they matched, you could be 
reasonably sure it was a hardware issue, otherwise, you would know your 
looking for a driver bug.

Neil

-- 
/***************************************************
  *Neil Horman
  *Software Engineer
  *Red Hat, Inc.
  *nhorman@redhat.com
  *gpg keyid: 1024D / 0x92A74FA1
  *http://pgp.mit.edu
  ***************************************************/
