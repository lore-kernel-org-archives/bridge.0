Message-ID: <2e59e6970803082338n20c9037p6ccae93654c58a69@mail.gmail.com>
Date: Sun, 9 Mar 2008 07:38:24 +0000
From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
In-Reply-To: <47D05B55.404@operations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <47D05B55.404@operations.com>
Subject: Re: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Lou Steinberg <lspam5@operations.com>
Cc: bridge@lists.linux-foundation.org

On Thu, Mar 6, 2008 at 9:00 PM, Lou Steinberg <lspam5@operations.com> wrote:
> Hi Folks-
>
>  Forgive the newbie question, but my attempts to answer this through
>  google have left me confused.
>
>  I'm trying to bridge between a pair of ppp and eth interfaces in an
>  embedded linux distribution called SlugOS.  The kernel is 2.6.21 and my
>  understanding was that the 2.6 kernels have the mods to support ppp
>  interfaces.  When I try to add my ppp0 interface to a bridge, I get:
>  > $ brctl addif test ppp0
>  > can't add ppp0 to bridge test: Invalid argument

Does a bridge "test" exist?  What is the output of brctl show?

>
>  MTUs are set the same for all interfaces.  Is there a specific version
>  of the bridge-utils package I need?  The version packed for my
>  distribution claims to be 1.2-r0
>
>  Thanks in advance,
>  Lou
>
>
>  _______________________________________________
>  Bridge mailing list
>  Bridge@lists.linux-foundation.org
>  https://lists.linux-foundation.org/mailman/listinfo/bridge
>
