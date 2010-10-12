From: Aijaz Baig <aijazbaig1@gmail.com>
Date: Tue, 12 Oct 2010 13:01:08 +0000 (UTC)
Message-ID: <loom.20101012T145743-585@post.gmane.org>
References: <loom.20101011T131053-288@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] About local delivery of bridged packets
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Aijaz Baig <aijazbaig1 <at> gmail.com> writes:

> 
> Hello,
> 
> I am trying to understand how does the bridging code determine if the packet 
is 
> to be delivered locally or is it to be forwarded. Before being delivered 
> locally, I mean the packet is to be delivered either to br0 or to a non 
enslaved 
> interface. If I am wrong here, please do correct me..................

Hello,

Heres answering my own question partially. Since the bridge which is after all a 
virtual interface takes one of the L2 addresses of its interfaces (is it the 
first real interface which is enslaved?), any packet which is destined with this 
L2 dest address in its eth header, will be considered locally destined.

This simple fact solves my issue.

Regards,
Aijaz


