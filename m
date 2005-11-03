Date: Thu, 3 Nov 2005 15:00:34 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] bridge-util
Message-ID: <20051103150034.0da54a1a@dxpl.pdx.osdl.net>
In-Reply-To: <20051102162444.60029.qmail@web32815.mail.mud.yahoo.com>
References: <20051102162444.60029.qmail@web32815.mail.mud.yahoo.com>
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
To: bridge@lists.osdl.org

On Wed, 2 Nov 2005 08:24:44 -0800 (PST)
jess patel <indian214soni@yahoo.com> wrote:

> I was looking into how to install bridge-util on linux once it is downloaded.
>  
> --p
> 
> 		
> ---------------------------------
>  Yahoo! FareChase - Search multiple travel sites in one click.  

Usual open source package build method:
 $ cd bridge-utils-1.0.6
 $ ./configure
 $ make

 $ sudo make install

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
