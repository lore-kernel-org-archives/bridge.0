Date: Tue, 1 Sep 2009 14:02:02 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20090901140202.5d3a15ad@nehalam>
In-Reply-To: <971341.46520.qm@web65703.mail.ac4.yahoo.com>
References: <971341.46520.qm@web65703.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge management through code
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "salaria113@yahoo.com" <salaria113@yahoo.com>
Cc: bridge@linux-foundation.org

On Sun, 30 Aug 2009 02:33:27 -0700 (PDT)
"salaria113@yahoo.com" <salaria113@yahoo.com> wrote:

> Hi,
> I need to create an user interface (QT based MMI) to manage bridge but I can't found c/c++ function in user space to develop this application.
> The functions are: br_add_bridge, br_del_bridge etc. in libbridge.a library are accessible from user space linking the library ?

There is no standard user library for this. You need to build your own interface.
Look at bridge utils source and RSTP daemon source. They use combinations of ioctl()'s,
sysfs and netlink.  Eventually, I hope to make all of bridge control under netlink
but for now you need ioctl's and sysfs.


-- 
