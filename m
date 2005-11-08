Date: Tue, 8 Nov 2005 09:28:11 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Bridge question
Message-ID: <20051108092811.52f8694e@localhost.localdomain>
In-Reply-To: <30be90270511080550i42c62b21webe50c58f16959f1@mail.gmail.com>
References: <DE026503646E7F40AF97BAB98334333BF0C972@uss-republic.finepoint.com>
	<30be90270511040955t7362da37m640573ff06c24243@mail.gmail.com>
	<30be90270511041016i25b04841o18e3fdf6a855d0f7@mail.gmail.com>
	<30be90270511041046n7b4ef6dalb3a235da6fba37a@mail.gmail.com>
	<20051104105720.02a93a7e@dxpl.pdx.osdl.net>
	<30be90270511041108l3c9414afp8526a70130e0f1dd@mail.gmail.com>
	<20051104113910.322bb270@dxpl.pdx.osdl.net>
	<30be90270511041214w2be63458s854bd8e51f850d05@mail.gmail.com>
	<20051104123442.0d12d7ed@dxpl.pdx.osdl.net>
	<30be90270511041319o2f97b74co83e64b2ca2937968@mail.gmail.com>
	<30be90270511080550i42c62b21webe50c58f16959f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Hai Wang <u2.ireland@gmail.com>
Cc: bridge@lists.osdl.org

On Tue, 8 Nov 2005 08:50:28 -0500
Hai Wang <u2.ireland@gmail.com> wrote:

> Hello Stephen,
>   I have two questions for you, please help me.
>   1. Are you aware that kernel panic issue when brtcl managed to remove
> interfaces on the bridge on RH9 (2.4.X)? it is random, it seems to me that
> it is racing issue? any fix?

Try 2.4.X latest first. Redhat kernels were a mix of 2.4 and 2.6.

>   2. I went through ChangeLog of kernel, I found
>  -------------------------------------------------------------------------------------------------
> 
> *Summary of changes from v2.6.6 to v2.6.7*
> 
> shemminger@osdl.org
> 
>       [BRIDGE]: Allow multiple interfaces with same address (necessary
> for VLAN's).
> 
> -----------------------------------------------------
> 
> it seems to me that ethernet bridge allows interfaces with same MACs
> address only on kernel 2.6.7 or later, right? If I want to backport
> the feature to kernel 2.4.x, what I should take care?

I only fix crashes on 2.4

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
