Date: Wed, 27 Jul 2005 10:48:26 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] heterogenous bridging
Message-ID: <20050727104826.4cadad1b@dxpl.pdx.osdl.net>
In-Reply-To: <20040726225949.0FBBB41606B@ws5-2.us4.outblaze.com>
References: <20040726225949.0FBBB41606B@ws5-2.us4.outblaze.com>
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
To: Tejas Kokje <kokje@linuxmail.org>
Cc: bridge@lists.osdl.org

On Mon, 26 Jul 2004 14:59:48 -0800
"Tejas Kokje" <kokje@linuxmail.org> wrote:

> 
> Hello,
> 
> I understand that bridge can make two ethernet interfaces appear as
> one logical interface. 
> 
> Now how does Linux Kernel does bridging between two different types
> of interfaces (Eg. 802.3 & 802.11). 
> 
> I am working on Linksys WRT54GS wireless router which runs Linux and
> have only one interface (br0) for both ethernet and wireless
> interface. All the packets I get on br0 have Ethernet (802.3) header.
> 
> Any inputs will be appreciated.
> 
> Regards,
> 
> Tejas Kokje
> Graduate Student (Computer Science)
> University of Southern California
> URL : http://www-scf.usc.edu/~kokje
> Registered Linux User #: 337673
> 

802.11 looks the same at the device level in the kernel. The wireless
devices accept the same data format packets and provide the same
control hooks.
