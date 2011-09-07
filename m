Date: Wed, 7 Sep 2011 07:45:09 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20110907074509.52ce6484@s6510.ftrdhcpuser.net>
In-Reply-To: <CAFhJ8JBPk1PM-sWrJrgTnOgZ02MXnYviWhVcs=Ht_bHpmdUC+Q@mail.gmail.com>
References: <20110905145807.GA9179@chii>
	<20110905094321.7e0f734c@nehalam.ftrdhcpuser.net>
	<CAFhJ8JBPk1PM-sWrJrgTnOgZ02MXnYviWhVcs=Ht_bHpmdUC+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] skip . and .. in accurately in isbridge()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Xiaochen Wang <wangxiaochen0@gmail.com>
Cc: Lennert Buytenhek <buytenh@gnu.org>, bridge@linux-foundation.org

On Wed, 7 Sep 2011 15:33:13 +0800
Xiaochen Wang <wangxiaochen0@gmail.com> wrote:

> On Tue, Sep 6, 2011 at 12:43 AM, Stephen Hemminger
> <shemminger@vyatta.com> wrote:
> > On Mon, 5 Sep 2011 22:58:07 +0800
> > Xiaochen Wang <wangxiaochen0@gmail.com> wrote:
> >
> >> Hi all,
> >>
> >> =A0In commit f88f8 "Skip . and .. in foreach_bridge test", the code sk=
ips
> >> =A0all directories starting with dot.
> >>
> >> =A0But if we create a bridge staring with dot, e.g. `.br0`, then `brct=
l show`
> >> =A0cannot show this one.
> >> =A0`.br0` should not be hidden, because we cannot find it except the c=
ommand
> >> =A0`brctl show .br0`.
> >>
> >> Signed-off-by: Xiaochen Wang <wangxiaochen0@gmail.com>
> >> ---
> >> =A0libbridge/libbridge_init.c | =A0 =A07 +++++--
> >> =A01 files changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/libbridge/libbridge_init.c b/libbridge/libbridge_init.c
> >> index 1c1acbd..177a391 100644
> >> --- a/libbridge/libbridge_init.c
> >> +++ b/libbridge/libbridge_init.c
> >> @@ -49,9 +49,12 @@ static int isbridge(const struct dirent *entry)
> >> =A0 =A0 =A0 char path[SYSFS_PATH_MAX];
> >> =A0 =A0 =A0 struct stat st;
> >>
> >> - =A0 =A0 if (entry->d_name[0] =3D=3D '.')
> >> + =A0 =A0 if (entry->d_name[0] =3D=3D '.'
> >> + =A0 =A0 =A0 =A0 && (entry->d_name[1] =3D=3D '\0'
> >> + =A0 =A0 =A0 =A0 =A0 =A0 || (entry->d_name[1] =3D=3D '.'
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && entry->d_name[2] =3D=3D '\0')))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> >> -
> >> +
> >> =A0 =A0 =A0 snprintf(path, SYSFS_PATH_MAX,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SYSFS_CLASS_NET "%s/bridge", entry->d_n=
ame);
> >> =A0 =A0 =A0 return stat(path, &st) =3D=3D 0 && S_ISDIR(st.st_mode);
> >
> > This was an accident originally, but allowing hidden bridges might be u=
seful.
> > And is common for other commands to not show names starting with .
> >
> I see.

I will apply your patch, just wanted to make sure no one was using
the old (buggy) behavior
