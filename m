Date: Fri, 18 Apr 2008 09:25:29 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080418092529.7596fc15@extreme>
In-Reply-To: <26b26d180804180221g479ee428u5c4e15a66152ceee@mail.gmail.com>
References: <26b26d180804180221g479ee428u5c4e15a66152ceee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] how to block STP bpdus on a particular port?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: saurav barik <saurav.barik@gmail.com>
Cc: bridge@lists.linux-foundation.org

On Fri, 18 Apr 2008 09:21:21 +0000
"saurav barik" <saurav.barik@gmail.com> wrote:

> Hi,
> 
> Can I refrain a particular port/interface on my linux bridge, to send
> and receive STP BPDUs?
> Is there any filter available for the same or should I customize linux
> bridge code?
> 
> I googled and browsed through the mailing list archives but could not
> find any solution.
> Please share some pointers.
> Thanks for your time.
> 
> Regards,
> Saurav
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

ebtables has an stp module.
