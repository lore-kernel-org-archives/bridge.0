Date: Fri, 6 Jan 2006 09:53:05 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] Re: Re: a problem about brctl
Message-ID: <20060106095305.6dfa5d09@dxpl.pdx.osdl.net>
In-Reply-To: <OA939893907741.15789@receive16.inner-21cn.com>
References: <OA939893907741.15789@receive16.inner-21cn.com>
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
To: "Haisen.Zhang" <zhs@cybertan.com.cn>
Cc: "bridge@osdl.org" <bridge@osdl.org>

On Fri, 6 Jan 2006 09:20:25 +0800
"Haisen.Zhang" <zhs@cybertan.com.cn> wrote:

> Stephen Hemminger,
> 	
> 
> 	Yes,I use V2.4.17.
> 	Which patch can I use?
> 	Or can you tell me the reason,so that i can modify my Kernel.I use this kernel at  the embeded system.

I don't keep track of patches for older kernels.
There were a number of fixes for bridging that went into 2.4 in the last year.
If you are using a vendor kernel, see if they picked up some of the fixes.
If you are building your own kernel, I recommend the latest from kernel.org (2.4.32).
The 2.4 kernel is in maintenance only mode at this point.
