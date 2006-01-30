Date: Mon, 30 Jan 2006 09:12:15 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Performance problem with linux bridge ... compare
	kernel 2.6.13.4 to 2.6.15.1
Message-ID: <20060130091215.68a74c55@dxpl.pdx.osdl.net>
In-Reply-To: <43DD4637.7090101@artcom.pl>
References: <43DD4637.7090101@artcom.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?UTF-8?B?UGF3ZcWC?= Staszewski <pstaszewski@artcom.pl>
Cc: Bridge List <bridge@lists.osdl.org>

On Sun, 29 Jan 2006 23:48:23 +0100
Paweł Staszewski <pstaszewski@artcom.pl> wrote:

> With kernel 2.6.13.4 linux bridge with traffic management for 4000users 
> and 20.4 MB/s(tx)/22.4 MB/s(rx) data load of CPU is max 50%
> With kernel 2.6.15.1 the same linux bridge with the same traffic has 
> 100% CPU load and in top I have ksoftirqd proccess.

Nothing jumps out as major changes. Could you get a profile?

If you really want to drill down then using git bisect will really
help find the offending patch.
