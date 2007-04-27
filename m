Date: Thu, 26 Apr 2007 21:07:21 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: Re: [Bridge] PVST
Message-ID: <20070426210721.3fcf9f08@localhost.localdomain>
In-Reply-To: <H00000690017cb31.1177634858.mail.pacificwireless.net.au@MHS>
References: <H00000690017cb31.1177634858.mail.pacificwireless.net.au@MHS>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Leigh Sharpe <lsharpe@pacificwireless.com.au>
Cc: bridge <bridge@lists.linux-foundation.org>

On Fri, 27 Apr 2007 10:47:42 +1000
"Leigh Sharpe" <lsharpe@pacificwireless.com.au> wrote:

> Hi All, 
> Does the current bridging code handle PVST properly, or just ordinary
> STP?

Ordinary, STP.  The 2.6.22 kernel will have all the bits to run STP in
user mode, and there is a version of RSTP in userspace see:
	git://git.kernel.org/pub/scm/linux/kernel/shemminger/git/rstp.git

The RSTP code uses the rstplib and it knows about VLAN's, but the hooks
aren't there yet. Eventually, full MSTP 802.Q seems like a good idea.

Someone had sent some patches to do PVST, but PVST seems to be Cisco
centric. and the patched version was too inflexible, so I didn't put
it in mainline.

