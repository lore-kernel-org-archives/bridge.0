Message-ID: <40D11F57.9070504@web.de>
Date: Thu, 17 Jun 2004 06:34:31 +0200
From: Michael Renzmann <mrenzmann@web.de>
MIME-Version: 1.0
Subject: Re: [Bridge] Bridging between user processes
References: <20040616221738.29758.qmail@web90108.mail.scd.yahoo.com>
In-Reply-To: <20040616221738.29758.qmail@web90108.mail.scd.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: mrenzmann@web.de
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Derek Smalls <dsmalls321@yahoo.com>
Cc: bridge@lists.osdl.org

Hi.

Derek Smalls wrote:
 >>I have not played with tun/tap myself, but the
 >>kernel documentation in
 >>Documentation/networking/tuntap.txt seems to
 >>indicate that you need a program to listen on two
 >>opened /dev/net/tun devices and copy the frames
 >>from one to the other.
> Thanks! I was afraid this was the reason ... :(
> 
> I actually tried writing an application that would
> open /dev/tap4 as a file and do a select() on it. 

The standalone tun-package [1] contains two example applications that 
act as simple bridges, one using SIGIO, one using select(). I guess it 
could be helpful for you to take a look at these examples.

[1] http://vtun.sourceforge.net/tun/tun-1.1.tar.gz

Bye, Mike
