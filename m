Date: Mon, 16 Feb 2004 09:05:06 -0800
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [Bridge] SIOCDEVPRIVATE
Message-Id: <20040216090506.4a252b08@dell_ss3.pdx.osdl.net>
In-Reply-To: <402D6682.80801@nortelnetworks.com>
References: <200402132000.i1DK09E17599@mail.osdl.org>
	<402D6682.80801@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Abhijit Kumbhare <abhijitk@nortelnetworks.com>
Cc: bridge@lists.osdl.org

On Fri, 13 Feb 2004 16:06:26 -0800
Abhijit Kumbhare <abhijitk@nortelnetworks.com> wrote:

> The bridge module uses this ioctl - but in the comment in 
> include/linux/sockios.h where it is defined says that the device private 
> IOCTL are "deprecated" and will disappear in 2.5.X (comment by DaveM).
> 
> I still see it being used in the 2.6.X bridge code - what's the story 
> behind this? Will SIOCDEVPRIVATE disappear or its just an invalid 
> comment because too many people/modules are using it (that it will never 
> be removed.

It probably won't disappear any time soon. I am working on a replacing the bridge
ioctl interface used now, because it doesn't work in mixed mode (32 bit command
talking to a 64bit kernel).  After that is done, maybe it will go away, but
there may be other devices that use it as well.  

Final decision would be up to Dave Miller.

