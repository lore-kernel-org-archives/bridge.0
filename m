Date: Mon, 1 Mar 2004 17:31:32 +0100
From: Software-team <software-team@wp.pl>
Message-Id: <20040301173132.6aeedb29@localhost.localdomain>
In-Reply-To: <200402282000.i1SK06E28411@mail.osdl.org>
References: <200402282000.i1SK06E28411@mail.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] i need some help with compiling bridge module
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

I am trying to improve bridge module towards 802.1w (RSTP) but I am new to kernel and modules programming. I dont want to compile the whole modules every time I make some changes. Could you give me some clues how to set up environment to compile only selected module (bridge 802.1d) for a given kernel version, written in Makefile like:
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 20
EXTRAVERSION =-8 etc.
How to make a Makefile so the bridge module could be compiled separately for that kernel (or another)?
Thanks for any specyfic help.
Software Team
