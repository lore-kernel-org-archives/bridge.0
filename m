Date: Mon, 10 May 2004 14:39:25 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040510143925.4e86594d@dell_ss3.pdx.osdl.net>
In-Reply-To: <24091224.1084150678092.JavaMail.www-data@c007.oddpost.com>
References: <24091224.1084150678092.JavaMail.www-data@c007.oddpost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: 4 port ethernet card bridge question
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Matthew Tanase <tanase@qaddisin.com>
Cc: bridge@osdl.org

On Sun, 9 May 2004 17:57:58 -0700 (PDT)
Matthew Tanase <tanase@qaddisin.com> wrote:

>  Hi 
>   
> I have a question for you - I know you probably get a lot but I figured I'd try. I've setup several bridges before using the code. Never had any problems. Recently I set Mandrake 10.0 up on a rackmount, with a builtin NIC and a 4 port ethernet card. Initially, I plugged 2 links into the 4 port ethernet card (eth1 and eth2) - and for the life of me, could not get it to work. Fiddled around, FINALLY got it to work but only with the following config. WAN link (link to the switch) in eth1 of the 4 port card and a PC plugged into eth0 - the onboard NIC. That's the ONLY way it will work (vice versa will not oddly enough). Any ideas? Linux recognizes the 4 port card as eth1-4 - is there something I'm missing? Thanks. 
>   
> mt 
>   
> -- 
> Matthew Tanase 
> President, Qaddisin 
> www.qaddisin.com 
> 314.496.2408 

Let's start with the obvious.  You need to make sure all the NIC's you want use work standalone
before you try bridging.  Usually, a simple test like bringing them up and doing a ping will verify
that packets are being successfully sent and received.  Also, were there any potential routing loops?
If somewhere downstream two ports are connected into the same hub or switch, then bridging won't work.
